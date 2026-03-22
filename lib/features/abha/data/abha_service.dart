import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'models/abha_profile.dart';
import 'models/abha_health_records.dart';

/// ABHA Service for managing Ayushman Bharat Health Account integration
/// Uses NHA (National Health Authority) APIs for OAuth2 flow and health records
class ABHAService {
  final FlutterSecureStorage _secureStorage;
  final Dio _dio;

  // NHA API endpoints - can be switched between sandbox and production
  static const String _sandboxBaseUrl = 'https://sandbox.abdm.gov.in';
  static const String _productionBaseUrl = 'https://abdm.gov.in';

  // Secure storage keys
  static const String _keyAccessToken = 'abha_access_token';
  static const String _keyRefreshToken = 'abha_refresh_token';
  static const String _keyTokenExpiry = 'abha_token_expiry';
  static const String _keyAbhaProfile = 'abha_profile';
  static const String _keyAbhaLinked = 'abha_linked';
  static const String _keyPatientId = 'abha_patient_id';

  // OAuth2 configuration
  static const String _clientId =
      'fitkarma_app'; // Replace with actual client ID from NHA
  static const String _clientSecret = ''; // Replace with actual secret
  static const String _redirectUri = 'fitkarma://abha-callback';

  bool _isProduction;

  ABHAService({
    required FlutterSecureStorage secureStorage,
    Dio? dio,
    bool isProduction = false,
  }) : _secureStorage = secureStorage,
       _dio = dio ?? Dio(),
       _isProduction = isProduction {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  String get _baseUrl => _isProduction ? _productionBaseUrl : _sandboxBaseUrl;

  /// Check if ABHA is linked
  Future<bool> isLinked() async {
    final linked = await _secureStorage.read(key: _keyAbhaLinked);
    return linked == 'true';
  }

  /// Get stored ABHA profile
  Future<ABHAProfile?> getProfile() async {
    try {
      final profileJson = await _secureStorage.read(key: _keyAbhaProfile);
      if (profileJson == null) return null;
      return ABHAProfile.fromJson(json.decode(profileJson));
    } catch (e) {
      debugPrint('Error reading ABHA profile: $e');
      return null;
    }
  }

  /// Generate OAuth2 authorization URL
  String getAuthorizationUrl(String state) {
    final params = {
      'response_type': 'code',
      'client_id': _clientId,
      'redirect_uri': _redirectUri,
      'scope':
          'openid profile patient/medication.read patient/condition.read patient/observation.read',
      'state': state,
      'acr_values': 'Level0',
    };

    final queryString = params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}',
        )
        .join('&');

    return '$_baseUrl/api/v1/authorize?$queryString';
  }

  /// Exchange authorization code for tokens
  Future<ABHATokenResponse?> exchangeCodeForTokens(String code) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/api/v1/token',
        data: {
          'grant_type': 'authorization_code',
          'code': code,
          'client_id': _clientId,
          'client_secret': _clientSecret,
          'redirect_uri': _redirectUri,
        },
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      if (response.statusCode == 200) {
        final tokenResponse = ABHATokenResponse.fromJson(response.data);
        await _saveTokens(tokenResponse);
        return tokenResponse;
      }
      return null;
    } on DioException catch (e) {
      debugPrint('ABHA token exchange error: ${e.message}');
      return null;
    }
  }

  /// Refresh access token
  Future<ABHATokenResponse?> refreshToken() async {
    try {
      final refreshToken = await _secureStorage.read(key: _keyRefreshToken);
      if (refreshToken == null) return null;

      final response = await _dio.post(
        '$_baseUrl/api/v1/token',
        data: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
          'client_id': _clientId,
          'client_secret': _clientSecret,
        },
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      if (response.statusCode == 200) {
        final tokenResponse = ABHATokenResponse.fromJson(response.data);
        await _saveTokens(tokenResponse);
        return tokenResponse;
      }
      return null;
    } on DioException catch (e) {
      debugPrint('ABHA token refresh error: ${e.message}');
      return null;
    }
  }

  /// Ensure we have a valid access token
  Future<String?> _getValidAccessToken() async {
    final expiryStr = await _secureStorage.read(key: _keyTokenExpiry);
    if (expiryStr != null) {
      final expiry = DateTime.tryParse(expiryStr);
      if (expiry != null &&
          expiry.isAfter(DateTime.now().add(const Duration(minutes: 5)))) {
        return await _secureStorage.read(key: _keyAccessToken);
      }
    }

    // Try to refresh token
    final newToken = await refreshToken();
    return newToken?.accessToken;
  }

  /// Fetch ABHA profile from NHA API
  Future<ABHAProfile?> fetchProfile() async {
    try {
      final accessToken = await _getValidAccessToken();
      if (accessToken == null) return null;

      final response = await _dio.get(
        '$_baseUrl/api/v1/patient/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final profile = ABHAProfile.fromJson(response.data);
        await _saveProfile(profile);
        return profile;
      }
      return null;
    } on DioException catch (e) {
      debugPrint('ABHA profile fetch error: ${e.message}');
      return null;
    }
  }

  /// Fetch health records (prescriptions, discharge summaries)
  Future<ABHARecordsResult> fetchHealthRecords({
    String? recordType,
    DateTime? fromDate,
    DateTime? toDate,
    int pageSize = 20,
    String? nextPageToken,
  }) async {
    try {
      final accessToken = await _getValidAccessToken();
      if (accessToken == null) {
        return const ABHARecordsResult(records: [], error: 'Not authenticated');
      }

      final queryParams = <String, dynamic>{'pageSize': pageSize};

      if (recordType != null) queryParams['recordType'] = recordType;
      if (fromDate != null)
        queryParams['fromDate'] = fromDate.toIso8601String();
      if (toDate != null) queryParams['toDate'] = toDate.toIso8601String();
      if (nextPageToken != null) queryParams['nextPageToken'] = nextPageToken;

      final response = await _dio.get(
        '$_baseUrl/api/v1/health_records',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return ABHARecordsResult.fromJson(response.data);
      }

      return const ABHARecordsResult(
        records: [],
        error: 'Failed to fetch records',
      );
    } on DioException catch (e) {
      debugPrint('ABHA health records fetch error: ${e.message}');
      return ABHARecordsResult(
        records: [],
        error: e.message ?? 'Network error',
      );
    }
  }

  /// Fetch prescriptions specifically
  Future<ABHARecordsResult> fetchPrescriptions({
    int pageSize = 20,
    String? nextPageToken,
  }) async {
    return fetchHealthRecords(
      recordType: 'prescription',
      pageSize: pageSize,
      nextPageToken: nextPageToken,
    );
  }

  /// Fetch discharge summaries specifically
  Future<ABHARecordsResult> fetchDischargeSummaries({
    int pageSize = 20,
    String? nextPageToken,
  }) async {
    return fetchHealthRecords(
      recordType: 'discharge_summary',
      pageSize: pageSize,
      nextPageToken: nextPageToken,
    );
  }

  /// Link ABHA ID manually (for cases where OAuth is not used)
  Future<bool> linkAbhaManual(String healthId, String? healthIdNumber) async {
    try {
      // Store the linked status
      await _secureStorage.write(key: _keyAbhaLinked, value: 'true');

      // Create a basic profile from the provided info
      final profile = ABHAProfile(
        healthId: healthId,
        healthIdNumber: healthIdNumber,
        isVerified: false,
        lastSyncedAt: DateTime.now(),
      );

      await _saveProfile(profile);
      return true;
    } catch (e) {
      debugPrint('Error linking ABHA manually: $e');
      return false;
    }
  }

  /// Unlink ABHA ID
  Future<bool> unlinkAbha() async {
    try {
      // Delete all ABHA-related data from secure storage
      await _secureStorage.delete(key: _keyAccessToken);
      await _secureStorage.delete(key: _keyRefreshToken);
      await _secureStorage.delete(key: _keyTokenExpiry);
      await _secureStorage.delete(key: _keyAbhaProfile);
      await _secureStorage.delete(key: _keyAbhaLinked);
      await _secureStorage.delete(key: _keyPatientId);

      return true;
    } catch (e) {
      debugPrint('Error unlinking ABHA: $e');
      return false;
    }
  }

  /// Save tokens to secure storage
  Future<void> _saveTokens(ABHATokenResponse tokens) async {
    await _secureStorage.write(key: _keyAccessToken, value: tokens.accessToken);
    if (tokens.refreshToken != null) {
      await _secureStorage.write(
        key: _keyRefreshToken,
        value: tokens.refreshToken,
      );
    }
    await _secureStorage.write(
      key: _keyTokenExpiry,
      value: tokens.expiresAt.toIso8601String(),
    );
    if (tokens.patientId != null) {
      await _secureStorage.write(key: _keyPatientId, value: tokens.patientId);
    }
  }

  /// Save profile to secure storage
  Future<void> _saveProfile(ABHAProfile profile) async {
    await _secureStorage.write(
      key: _keyAbhaProfile,
      value: json.encode(profile.toJson()),
    );
    await _secureStorage.write(key: _keyAbhaLinked, value: 'true');
  }

  /// Set production mode
  void setProductionMode(bool isProduction) {
    _isProduction = isProduction;
  }

  /// Get patient ID
  Future<String?> getPatientId() async {
    return await _secureStorage.read(key: _keyPatientId);
  }
}

/// Provider for ABHAService
final abhaServiceProvider = Provider<ABHAService>((ref) {
  // This will be overridden with the actual secure storage from providers.dart
  throw UnimplementedError(
    'ABHA Service must be initialized with secure storage',
  );
});
