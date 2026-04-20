import 'package:appwrite/appwrite.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import '../constants/api_endpoints.dart';

/// Singleton class to manage the Appwrite Client and its services.
class AppwriteClient {
  // Private constructor to prevent instantiation
  AppwriteClient._();

  static late final Client _client;
  static late final Account _account;
  static late final Databases _databases;
  static late final Storage _storage;
  static late final Realtime _realtime;
  static late final Functions _functions;

  /// Getters for Appwrite services
  static Client get client => _client;
  static Account get account => _account;
  static Databases get databases => _databases;
  static Storage get storage => _storage;
  static Realtime get realtime => _realtime;
  static Functions get functions => _functions;

  /// Initializes the Appwrite Client and all dependent services.
  /// This must be called in main() before runApp().
  static Future<void> initialize() async {
    final endpoint = AW.endpoint;
    final projectId = AW.projectId;
    
    // 1. Certificate Pinning Verification (MITM Security)
    const fingerprint = String.fromEnvironment('APPWRITE_CERT_FINGERPRINT');
    if (fingerprint.isNotEmpty) {
      try {
        await HttpCertificatePinning.check(
          serverURL: endpoint,
          sha256Fingerprints: [fingerprint],
          timeout: 10,
        );
      } catch (e) {
        // In a real premium app, we should handle this gracefully (e.g., show error screen)
        // For development, we log and proceed if fingerprint is empty.
        rethrow; // Blocking execution if pinning fails
      }
    }

    _client = Client()
      ..setEndpoint(endpoint)
      ..setProject(projectId)
      ..setSelfSigned(status: false);

    _account = Account(_client);
    _databases = Databases(_client);
    _storage = Storage(_client);
    _realtime = Realtime(_client);
    _functions = Functions(_client);
  }
}

