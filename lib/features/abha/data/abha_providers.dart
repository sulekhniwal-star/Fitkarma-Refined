import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'abha_service.dart';
import 'models/abha_profile.dart';
import 'models/abha_health_records.dart';

/// ABHA linking state
enum ABHALinkingStatus { initial, loading, linked, unlinking, error }

/// ABHA state notifier for managing ABHA link state
class ABHAStateNotifier extends ChangeNotifier {
  final ABHAService _service;
  ABHALinkingStatus _status = ABHALinkingStatus.initial;

  ABHAStateNotifier(this._service);

  ABHALinkingStatus get status => _status;

  /// Check and update ABHA linking status
  Future<void> checkStatus() async {
    _status = ABHALinkingStatus.loading;
    notifyListeners();

    try {
      final isLinked = await _service.isLinked();
      _status = isLinked ? ABHALinkingStatus.linked : ABHALinkingStatus.initial;
    } catch (e) {
      _status = ABHALinkingStatus.error;
    }
    notifyListeners();
  }

  /// Link ABHA with OAuth2
  Future<bool> linkWithOAuth(String authorizationCode) async {
    _status = ABHALinkingStatus.loading;
    notifyListeners();

    try {
      final tokens = await _service.exchangeCodeForTokens(authorizationCode);
      if (tokens != null) {
        // Fetch and save profile
        final profile = await _service.fetchProfile();
        if (profile != null) {
          _status = ABHALinkingStatus.linked;
          notifyListeners();
          return true;
        }
      }
      _status = ABHALinkingStatus.error;
      notifyListeners();
      return false;
    } catch (e) {
      _status = ABHALinkingStatus.error;
      notifyListeners();
      return false;
    }
  }

  /// Link ABHA manually
  Future<bool> linkManual(String healthId, String? healthIdNumber) async {
    _status = ABHALinkingStatus.loading;
    notifyListeners();

    try {
      final success = await _service.linkAbhaManual(healthId, healthIdNumber);
      _status = success ? ABHALinkingStatus.linked : ABHALinkingStatus.error;
      notifyListeners();
      return success;
    } catch (e) {
      _status = ABHALinkingStatus.error;
      notifyListeners();
      return false;
    }
  }

  /// Unlink ABHA
  Future<bool> unlink() async {
    _status = ABHALinkingStatus.unlinking;
    notifyListeners();

    try {
      final success = await _service.unlinkAbha();
      _status = success ? ABHALinkingStatus.initial : ABHALinkingStatus.error;
      notifyListeners();
      return success;
    } catch (e) {
      _status = ABHALinkingStatus.error;
      notifyListeners();
      return false;
    }
  }
}

/// ABHA profile state
class ABHAProfileState {
  final ABHAProfile? profile;
  final bool isLoading;
  final String? error;

  const ABHAProfileState({this.profile, this.isLoading = false, this.error});

  ABHAProfileState copyWith({
    ABHAProfile? profile,
    bool? isLoading,
    String? error,
  }) {
    return ABHAProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  bool get isLinked => profile != null;
  bool get isVerified => profile?.isVerified ?? false;
}

/// ABHA profile notifier
class ABHAProfileNotifier extends ChangeNotifier {
  final ABHAService _service;
  ABHAProfileState _state = const ABHAProfileState();

  ABHAProfileNotifier(this._service);

  ABHAProfileState get state => _state;

  /// Load profile from storage
  Future<void> loadProfile() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final profile = await _service.getProfile();
      _state = ABHAProfileState(profile: profile, isLoading: false);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }
    notifyListeners();
  }

  /// Refresh profile from NHA API
  Future<void> refreshProfile() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final profile = await _service.fetchProfile();
      _state = ABHAProfileState(profile: profile, isLoading: false);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }
    notifyListeners();
  }
}

/// ABHA health records state
class ABHAHealthRecordsState {
  final List<ABHAHealthRecord> prescriptions;
  final List<ABHAHealthRecord> dischargeSummaries;
  final bool isLoadingPrescriptions;
  final bool isLoadingDischargeSummaries;
  final String? error;

  const ABHAHealthRecordsState({
    this.prescriptions = const [],
    this.dischargeSummaries = const [],
    this.isLoadingPrescriptions = false,
    this.isLoadingDischargeSummaries = false,
    this.error,
  });

  ABHAHealthRecordsState copyWith({
    List<ABHAHealthRecord>? prescriptions,
    List<ABHAHealthRecord>? dischargeSummaries,
    bool? isLoadingPrescriptions,
    bool? isLoadingDischargeSummaries,
    String? error,
  }) {
    return ABHAHealthRecordsState(
      prescriptions: prescriptions ?? this.prescriptions,
      dischargeSummaries: dischargeSummaries ?? this.dischargeSummaries,
      isLoadingPrescriptions:
          isLoadingPrescriptions ?? this.isLoadingPrescriptions,
      isLoadingDischargeSummaries:
          isLoadingDischargeSummaries ?? this.isLoadingDischargeSummaries,
      error: error,
    );
  }

  bool get isLoading => isLoadingPrescriptions || isLoadingDischargeSummaries;
  bool get hasRecords =>
      prescriptions.isNotEmpty || dischargeSummaries.isNotEmpty;
}

/// ABHA health records notifier
class ABHAHealthRecordsNotifier extends ChangeNotifier {
  final ABHAService _service;
  ABHAHealthRecordsState _state = const ABHAHealthRecordsState();

  ABHAHealthRecordsNotifier(this._service);

  ABHAHealthRecordsState get state => _state;

  /// Fetch prescriptions
  Future<void> fetchPrescriptions() async {
    _state = _state.copyWith(isLoadingPrescriptions: true, error: null);
    notifyListeners();

    try {
      final result = await _service.fetchPrescriptions();
      if (result.hasError) {
        _state = _state.copyWith(
          isLoadingPrescriptions: false,
          error: result.error,
        );
      } else {
        _state = _state.copyWith(
          prescriptions: result.records,
          isLoadingPrescriptions: false,
        );
      }
    } catch (e) {
      _state = _state.copyWith(
        isLoadingPrescriptions: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  /// Fetch discharge summaries
  Future<void> fetchDischargeSummaries() async {
    _state = _state.copyWith(isLoadingDischargeSummaries: true, error: null);
    notifyListeners();

    try {
      final result = await _service.fetchDischargeSummaries();
      if (result.hasError) {
        _state = _state.copyWith(
          isLoadingDischargeSummaries: false,
          error: result.error,
        );
      } else {
        _state = _state.copyWith(
          dischargeSummaries: result.records,
          isLoadingDischargeSummaries: false,
        );
      }
    } catch (e) {
      _state = _state.copyWith(
        isLoadingDischargeSummaries: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  /// Fetch all health records
  Future<void> fetchAll() async {
    await Future.wait([fetchPrescriptions(), fetchDischargeSummaries()]);
  }

  /// Clear records
  void clear() {
    _state = const ABHAHealthRecordsState();
    notifyListeners();
  }
}

// =============================================================================
// Providers
// =============================================================================

/// Global ABHA service instance
ABHAService? _abhaService;

/// Initialize ABHA service
void initABHAService(FlutterSecureStorage secureStorage, bool isProduction) {
  _abhaService = ABHAService(
    secureStorage: secureStorage,
    isProduction: isProduction,
  );
}

/// Provider for ABHA service
final abhaServiceProvider = Provider<ABHAService?>((ref) {
  return _abhaService;
});

/// Provider for ABHA linking status
final abhaLinkingStatusProvider = Provider<ABHAStateNotifier>((ref) {
  final service = ref.watch(abhaServiceProvider);
  if (service == null) {
    throw Exception('ABHA Service not initialized');
  }
  return ABHAStateNotifier(service);
});

/// Provider for ABHA profile
final abhaProfileProvider = Provider<ABHAProfileNotifier>((ref) {
  final service = ref.watch(abhaServiceProvider);
  if (service == null) {
    throw Exception('ABHA Service not initialized');
  }
  return ABHAProfileNotifier(service);
});

/// Provider for ABHA health records
final abhaHealthRecordsProvider = Provider<ABHAHealthRecordsNotifier>((ref) {
  final service = ref.watch(abhaServiceProvider);
  if (service == null) {
    throw Exception('ABHA Service not initialized');
  }
  return ABHAHealthRecordsNotifier(service);
});

/// Provider for checking if ABHA is linked
final isAbhaLinkedProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(abhaServiceProvider);
  if (service == null) return false;
  return service.isLinked();
});

/// Provider for getting authorization URL
final abhaAuthorizationUrlProvider = Provider<String>((ref) {
  final service = ref.watch(abhaServiceProvider);
  if (service == null) {
    // Return a placeholder URL when service is not initialized
    return 'https://sandbox.abdm.gov.in/api/v1/authorize';
  }
  // Generate a random state for CSRF protection
  final state = DateTime.now().millisecondsSinceEpoch.toString();
  return service.getAuthorizationUrl(state);
});
