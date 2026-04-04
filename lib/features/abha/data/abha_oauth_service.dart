import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class AbhaOAuthService {
  AbhaOAuthService._();

  static final AbhaOAuthService instance = AbhaOAuthService._();

  static const _accessTokenKey = 'abha_access_token';
  static const _refreshTokenKey = 'abha_refresh_token';
  static const _tokenExpiryKey = 'abha_token_expiry';

  static const _clientId = 'SBX_FITKARMA';
  static const _clientSecret = 'FITKARMA_SECRET';
  static const _redirectUri = 'fitkarma://abha/callback';
  static const _authUrl = 'https://auth.abdm.gov.in/v3/auth/authorize';
  static const _tokenUrl = 'https://auth.abdm.gov.in/v3/auth/token';

  final _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  String _generateCodeVerifier() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64Url.encode(Uint8List.fromList(bytes)).replaceAll('=', '');
  }

  String _generateCodeChallenge(String verifier) {
    final bytes = utf8.encode(verifier);
    final hash = sha256.convert(bytes);
    return base64Url.encode(hash.bytes).replaceAll('=', '');
  }

  Future<AbhaAuthUrl> buildAuthUrl() async {
    final codeVerifier = _generateCodeVerifier();
    final codeChallenge = _generateCodeChallenge(codeVerifier);
    final state = _generateCodeVerifier().substring(0, 16);
    
    await _secureStorage.write(key: 'abha_code_verifier_$state', value: codeVerifier);
    
    final params = {
      'response_type': 'code',
      'client_id': _clientId,
      'redirect_uri': _redirectUri,
      'scope': 'openid profile abha_enrollment',
      'state': state,
      'code_challenge': codeChallenge,
      'code_challenge_method': 'S256',
      'display': 'page',
      'prompt': 'login',
    };
    
    final url = '$_authUrl?${Uri(queryParameters: params).query}';
    
    return AbhaAuthUrl(url: url, state: state);
  }

  Future<AbhaTokens?> exchangeCodeForTokens(String code, String state) async {
    final codeVerifier = await _secureStorage.read(key: 'abha_code_verifier_$state');
    if (codeVerifier == null) return null;
    
    await _secureStorage.delete(key: 'abha_code_verifier_$state');
    
    try {
      final response = await http.post(
        Uri.parse(_tokenUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'authorization_code',
          'code': code,
          'client_id': _clientId,
          'client_secret': _clientSecret,
          'redirect_uri': _redirectUri,
          'code_verifier': codeVerifier,
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        final accessToken = data['access_token'];
        final refreshToken = data['refresh_token'];
        final expiresIn = data['expires_in'] as int? ?? 3600;
        
        await storeTokens(accessToken, refreshToken, expiresIn);
        
        return AbhaTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresIn: expiresIn,
        );
      }
    } catch (e) {
      debugPrint('ABHA token exchange failed: $e');
    }
    return null;
  }

  Future<void> storeTokens(String accessToken, String refreshToken, int expiresIn) async {
    final expiry = DateTime.now().add(Duration(seconds: expiresIn));
    
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
    await _secureStorage.write(key: _tokenExpiryKey, value: expiry.toIso8601String());
  }

  Future<String?> getValidAccessToken() async {
    final expiryStr = await _secureStorage.read(key: _tokenExpiryKey);
    if (expiryStr == null) return null;
    
    final expiry = DateTime.tryParse(expiryStr);
    if (expiry == null || expiry.isBefore(DateTime.now().add(const Duration(minutes: 1)))) {
      return refreshToken();
    }
    
    return _secureStorage.read(key: _accessTokenKey);
  }

  Future<String?> refreshToken() async {
    final refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    if (refreshToken == null) return null;
    
    try {
      final response = await http.post(
        Uri.parse(_tokenUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
          'client_id': _clientId,
          'client_secret': _clientSecret,
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        final accessToken = data['access_token'];
        final newRefreshToken = data['refresh_token'] ?? refreshToken;
        final expiresIn = data['expires_in'] as int? ?? 3600;
        
        await storeTokens(accessToken, newRefreshToken, expiresIn);
        
        return accessToken;
      }
    } catch (e) {
      debugPrint('ABHA token refresh failed: $e');
    }
    
    return null;
  }

  Future<bool> hasValidToken() async {
    final token = await getValidAccessToken();
    return token != null;
  }

  Future<void> unlinkAbha(String userId) async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
    await _secureStorage.delete(key: _tokenExpiryKey);
    
    final db = AppDatabase();
    await db.abhaLinksDao.unlinkAbha(userId);
  }

  Future<bool> isLinked() async {
    final token = await getValidAccessToken();
    return token != null;
  }
}

class AbhaAuthUrl {
  final String url;
  final String state;

  AbhaAuthUrl({required this.url, required this.state});
}

class AbhaTokens {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  AbhaTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });
}

class AbhaAuthException implements Exception {
  final String message;
  AbhaAuthException(this.message);

  @override
  String toString() => message;
}