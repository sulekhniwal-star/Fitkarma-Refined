import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../constants/app_config.dart';

part 'appwrite_service.g.dart';

@riverpod
Client appwriteClient(Ref ref) {
  final client = Client()
    ..setEndpoint(AppConfig.appwriteEndpoint)
    ..setProject(AppConfig.appwriteProjectId)
    ..setSelfSigned(status: true); // For self-hosted/dev environments
  return client;
}

@riverpod
Account appwriteAccount(Ref ref) {
  return Account(ref.watch(appwriteClientProvider));
}

@riverpod
Databases appwriteDatabases(Ref ref) {
  return Databases(ref.watch(appwriteClientProvider));
}

@riverpod
Storage appwriteStorage(Ref ref) {
  return Storage(ref.watch(appwriteClientProvider));
}

@riverpod
Realtime appwriteRealtime(Ref ref) {
  return Realtime(ref.watch(appwriteClientProvider));
}

@riverpod
Functions appwriteFunctions(Ref ref) {
  return Functions(ref.watch(appwriteClientProvider));
}
