import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../constants/app_config.dart';

part 'appwrite_service.g.dart';

@riverpod
Client appwriteClient(AppwriteClientRef ref) {
  final client = Client()
    ..setEndpoint(AppConfig.appwriteEndpoint)
    ..setProject(AppConfig.appwriteProjectId)
    ..setSelfSigned(status: true); // For self-hosted/dev environments
  return client;
}

@riverpod
Account appwriteAccount(AppwriteAccountRef ref) {
  return Account(ref.watch(appwriteClientProvider));
}

@riverpod
Databases appwriteDatabases(AppwriteDatabasesRef ref) {
  return Databases(ref.watch(appwriteClientProvider));
}

@riverpod
Storage appwriteStorage(AppwriteStorageRef ref) {
  return Storage(ref.watch(appwriteClientProvider));
}

@riverpod
Realtime appwriteRealtime(AppwriteRealtimeRef ref) {
  return Realtime(ref.watch(appwriteClientProvider));
}
