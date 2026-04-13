import 'package:appwrite/appwrite.dart';
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
    _client = Client()
      ..setEndpoint(AW.endpoint)
      ..setProject(AW.projectId)
      ..setSelfSigned(status: false);

    /*
     * --------------------------------------------------------------------------
     * CERTIFICATE PINNING NOTE:
     * --------------------------------------------------------------------------
     * To further secure the connection against Man-in-the-Middle (MitM) attacks,
     * implement certificate pinning here.
     * 
     * Options:
     * 1. Use the 'http_certificate_pinning' package to verify the SHA-256 fingerprint
     *    of the server's certificate.
     * 2. Implement a custom security context via a native channel for Android (Network Security Config)
     *    and iOS (TrustKit or similar).
     * 
     * Implementation example with http_certificate_pinning:
     * try {
     *   await HttpCertificatePinning.check(
     *     serverURL: AW.endpoint,
     *     sha256Fingerprints: [String.fromEnvironment('APPWRITE_CERT_FINGERPRINT')],
     *     timeout: 10,
     *   );
     * } catch (e) {
     *   // Handle verification failure (e.g., terminate app or show error)
     * }
     * --------------------------------------------------------------------------
     */

    _account = Account(_client);
    _databases = Databases(_client);
    _storage = Storage(_client);
    _realtime = Realtime(_client);
    _functions = Functions(_client);
  }
}
