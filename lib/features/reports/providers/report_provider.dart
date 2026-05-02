import 'dart:io';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/config/app_config.dart';
import '../../auth/providers/auth_provider.dart';
import '../../steps/providers/steps_provider.dart';
import '../repositories/reports_repository.dart';

part 'report_provider.g.dart';

@riverpod
class LabReportNotifier extends _$LabReportNotifier {
  @override
  bool build() => false;

  Future<String> uploadFile(File file) async {
    final storage = ref.read(appwriteStorageProvider);
    final id = const Uuid().v4();
    
    // In a real app, we'd use InputFile.fromPath
    // await storage.createFile(
    //   bucketId: AppConfig.mediaBucket,
    //   fileId: id,
    //   file: InputFile.fromPath(path: file.path),
    // );
    
    return id;
  }

  Future<void> importFromOCR(File file) async {
    final authState = ref.read(authProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final fileId = await uploadFile(file);
    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();

    final companion = LabReportsCompanion.insert(
      id: id,
      userId: user.$id,
      fileName: file.path.split(Platform.pathSeparator).last,
      fileId: fileId,
      createdAt: DateTime.now(),
      reportDate: Value(DateTime.now()),
      extractedDataJson: const Value('{"status": "processing"}'),
      syncStatus: const Value('pending'),
    );

    await db.into(db.labReports).insert(companion);
    
    _pushToRemote(id);
    
    // Optional: Call Appwrite Function for actual OCR processing
    try {
      await ref.read(appwriteFunctionsProvider).createExecution(
        functionId: 'report-ocr',
        body: '{"reportId": "$id", "fileId": "$fileId"}',
      );
    } catch (_) {}
  }

  Future<void> _pushToRemote(String id) async {
    try {
      await ref.read(reportsRepositoryProvider).pushReportToRemote(id);
    } catch (_) {}
  }

  Future<void> deleteReport(String id) async {
    final db = ref.read(appDatabaseProvider);
    await (db.delete(db.labReports)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
Stream<List<dynamic>> labReports(Ref ref) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value([]);

  return ref.watch(appDatabaseProvider).watchLabReports(user.$id);
}

@riverpod
Future<String> shareLink(Ref ref, String reportId) async {
  try {
    final execution = await ref.read(appwriteFunctionsProvider).createExecution(
      functionId: 'report-share',
      body: '{"reportId": "$reportId"}',
    );
    // Assuming the function returns the URL in response body
    return execution.responseBody;
  } catch (e) {
    return "https://fitkarma.app/share/report/$reportId";
  }
}

@riverpod
Future<Map<String, dynamic>> healthReport(Ref ref, String period) async {
  final steps = await ref.watch(stepsProvider.future);
  
  return {
    'period': period,
    'totalSteps': steps,
    'insight': "Weekly summary: You covered $steps steps. Great progress!",
  };
}
