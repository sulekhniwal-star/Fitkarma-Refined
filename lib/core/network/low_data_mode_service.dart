import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing Low Data Mode settings and connection speed detection.
///
/// This service provides:
/// - A stream of the current Low Data Mode status (`lowDataModeStream`).
/// - Methods to manually enable/disable Low Data Mode.
/// - Automatic detection of slow connections (e.g., 2G) to enable Low Data Mode.
/// - Persisted settings using SharedPreferences.
class LowDataModeService {
  final Connectivity _connectivity;
  final SharedPreferences _prefs;

  // Static instance for singleton access
  static LowDataModeService? _instance;
  static LowDataModeService get instance => _instance!;

  // BehaviorSubject allows us to get the last emitted value
  final _lowDataModeSubject = BehaviorSubject<bool>.seeded(false);

  // Key for storing the setting
  static const String _lowDataModeKey = 'low_data_mode_enabled';

  // Key for storing auto-detect preference
  static const String _autoDetectKey = 'low_data_mode_auto_detect';

  /// Stream of the current Low Data Mode status.
  ///
  /// Emits `true` if Low Data Mode is enabled, `false` otherwise.
  Stream<bool> get lowDataModeStream => _lowDataModeSubject.stream;

  /// The current status of Low Data Mode.
  bool get isLowDataModeEnabled => _lowDataModeSubject.value;

  /// Whether auto-detect is enabled
  bool get isAutoDetectEnabled => _prefs.getBool(_autoDetectKey) ?? true;

  LowDataModeService(this._connectivity, this._prefs) {
    // Set static instance
    _instance = this;

    // Load the persisted setting on startup
    _loadPersistedSetting();

    // Listen for connectivity changes
    _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  /// Load the persisted setting from SharedPreferences.
  Future<void> _loadPersistedSetting() async {
    final isEnabled = _prefs.getBool(_lowDataModeKey) ?? false;
    _lowDataModeSubject.add(isEnabled);
  }

  /// Manually enable or disable Low Data Mode.
  Future<void> setLowDataMode(bool isEnabled) async {
    await _prefs.setBool(_lowDataModeKey, isEnabled);
    // If user manually enables, also enable auto-detect
    if (isEnabled) {
      await _prefs.setBool(_autoDetectKey, true);
    }
    _lowDataModeSubject.add(isEnabled);
  }

  /// Enable or disable auto-detect of slow connections
  Future<void> setAutoDetect(bool isEnabled) async {
    await _prefs.setBool(_autoDetectKey, isEnabled);
    // If auto-detect is enabled, check current connection
    if (isEnabled) {
      await _checkAndAutoEnable();
    }
  }

  /// Check connectivity status and update Low Data Mode if necessary.
  ///
  /// This method automatically enables Low Data Mode on slow connections
  /// (e.g., 2G, 3G, mobile data) when auto-detect is enabled.
  Future<void> _updateConnectivityStatus(
    List<ConnectivityResult> results,
  ) async {
    // Only auto-enable if auto-detect is enabled
    if (!isAutoDetectEnabled) {
      return;
    }

    await _checkAndAutoEnable();
  }

  /// Check current connection and auto-enable if slow
  Future<void> _checkAndAutoEnable() async {
    final result = await _connectivity.checkConnectivity();
    final isSlowConnection = _isSlowConnection(result);

    // Auto-enable on slow connections, auto-disable on WiFi
    if (isSlowConnection) {
      // Only auto-enable if user hasn't manually disabled
      final manualOverride = _prefs.getBool(_lowDataModeKey);
      if (manualOverride != false) {
        await _prefs.setBool(_lowDataModeKey, true);
        _lowDataModeSubject.add(true);
        print('LowDataMode: Auto-enabled due to slow connection');
      }
    } else if (result.contains(ConnectivityResult.wifi)) {
      // Auto-disable on WiFi (user can still manually enable)
      final manualOverride = _prefs.getBool(_lowDataModeKey);
      if (manualOverride == null) {
        // Only clear if it was auto-enabled
        await _prefs.setBool(_lowDataModeKey, false);
        _lowDataModeSubject.add(false);
      }
    }
  }

  /// Determine if connection is slow based on connectivity result
  bool _isSlowConnection(List<ConnectivityResult> results) {
    // Mobile data is considered slow/limited
    if (results.contains(ConnectivityResult.mobile)) {
      return true;
    }
    // 'other' includes Bluetooth, VPN, etc. - treat as potentially slow
    if (results.contains(ConnectivityResult.other)) {
      return true;
    }
    // No connectivity
    if (results.contains(ConnectivityResult.none)) {
      return true;
    }
    return false;
  }

  /// Get the recommended sync interval based on low data mode
  /// Returns duration in minutes
  int get syncIntervalMinutes {
    return isLowDataModeEnabled ? 360 : 15; // 6 hours vs 15 minutes
  }

  /// Dispose the service.
  void dispose() {
    _lowDataModeSubject.close();
  }
}
