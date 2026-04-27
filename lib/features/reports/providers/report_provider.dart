import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';
import '../../steps/providers/steps_provider.dart';

part 'report_provider.g.dart';

@riverpod
class LabReportNotifier extends _$LabReportNotifier {
  @override
  void build() {}

  Future<String> uploadFile(File file) async {
    // In a real app, use ref.read(appwriteStorageProvider).createFile(...)
    return const Uuid().v4();
  }

  Future<void> importFromOCR(File file) async {
    final authState = ref.read(authNotifierProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final fileId = await uploadFile(file);
    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();

    final companion = LabReportsCompanion.insert(
      id: id,
      userId: user.$id,
      fileName: file.path.split('/').last,
      fileId: fileId,
      createdAt: DateTime.now(),
    );

    await db.into(db.labReports).insert(companion);
  }
}

@riverpod
Stream<List<LabReport>> labReports(LabReportsRef ref) {
  final authState = ref.watch(authNotifierProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value([]);

  return ref.watch(appDatabaseProvider).watchLabReports(user.$id);
}

@riverpod
Future<String> shareLink(ShareLinkRef ref, String reportId) async {
  return "https://fitkarma.app/share/report/$reportId";
}

@riverpod
Map<String, dynamic> healthReport(HealthReportRef ref, String period) {
  final steps = ref.watch(stepsProvider).asData?.value ?? 0;
  
  return {
    'period': period,
    'totalSteps': steps,
    'insight': "Weekly summary: You covered $steps steps. Great progress!",
  };
}
