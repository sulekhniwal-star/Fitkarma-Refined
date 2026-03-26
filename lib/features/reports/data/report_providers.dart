// lib/features/reports/data/report_providers.dart
// Riverpod providers for reports feature

import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/reports/data/report_data.dart';
import 'package:fitkarma/features/reports/data/report_service.dart';
import 'package:fitkarma/features/reports/data/report_storage_service.dart';

/// Provider for saved reports list
final savedReportsProvider = FutureProvider<List<ReportFileInfo>>((ref) async {
  final storageService = ReportStorageService();
  return storageService.getSavedReports();
});

/// State for report generation
class ReportGenerationState {
  final bool isGenerating;
  final String? error;
  final String? lastGeneratedPath;

  ReportGenerationState({
    this.isGenerating = false,
    this.error,
    this.lastGeneratedPath,
  });

  ReportGenerationState copyWith({
    bool? isGenerating,
    String? error,
    String? lastGeneratedPath,
  }) {
    return ReportGenerationState(
      isGenerating: isGenerating ?? this.isGenerating,
      error: error,
      lastGeneratedPath: lastGeneratedPath ?? this.lastGeneratedPath,
    );
  }
}

/// Simple state notifier using Notifier pattern for Riverpod 3.x
class ReportGenerationNotifier extends Notifier<ReportGenerationState> {
  @override
  ReportGenerationState build() {
    return ReportGenerationState();
  }

  ReportService get _reportService => ref.read(reportServiceProvider);

  /// Generate a weekly report
  Future<String?> generateWeeklyReport({
    required String userId,
    required String userName,
  }) async {
    state = state.copyWith(isGenerating: true, error: null);

    try {
      // TODO: Get database from provider
      // For now, return null - will be implemented when database provider is wired up
      state = state.copyWith(
        isGenerating: false,
        error: 'Database not configured',
      );
      return null;
    } catch (e) {
      state = state.copyWith(isGenerating: false, error: e.toString());
      return null;
    }
  }

  /// Generate a monthly report
  Future<String?> generateMonthlyReport({
    required String userId,
    required String userName,
  }) async {
    state = state.copyWith(isGenerating: true, error: null);

    try {
      // TODO: Get database from provider
      state = state.copyWith(
        isGenerating: false,
        error: 'Database not configured',
      );
      return null;
    } catch (e) {
      state = state.copyWith(isGenerating: false, error: e.toString());
      return null;
    }
  }

  /// Delete a saved report
  Future<bool> deleteReport(String filePath) async {
    final success = await _reportService.deleteReport(filePath);
    if (success) {
      ref.invalidate(savedReportsProvider);
    }
    return success;
  }

  /// Read report bytes
  Future<Uint8List?> readReport(String filePath) async {
    return _reportService.readReport(filePath);
  }
}

/// Provider for report generation state
final reportGenerationProvider =
    NotifierProvider<ReportGenerationNotifier, ReportGenerationState>(() {
      return ReportGenerationNotifier();
    });

/// Share link state
class ShareLinkState {
  final bool isLoading;
  final String? shareUrl;
  final String? error;
  final List<ShareLinkInfo> activeLinks;

  ShareLinkState({
    this.isLoading = false,
    this.shareUrl,
    this.error,
    this.activeLinks = const [],
  });

  ShareLinkState copyWith({
    bool? isLoading,
    String? shareUrl,
    String? error,
    List<ShareLinkInfo>? activeLinks,
  }) {
    return ShareLinkState(
      isLoading: isLoading ?? this.isLoading,
      shareUrl: shareUrl,
      error: error,
      activeLinks: activeLinks ?? this.activeLinks,
    );
  }
}

/// Share link notifier
class ShareLinkNotifier extends Notifier<ShareLinkState> {
  @override
  ShareLinkState build() {
    return ShareLinkState();
  }

  /// Generate a new doctor shareable link
  Future<String?> generateShareLink({
    required String userId,
    required String userName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final now = DateTime.now();

      // Generate share token
      final shareToken = DateTime.now().millisecondsSinceEpoch.toRadixString(
        36,
      );
      final expiresAt = now.add(const Duration(days: 7));

      // Create share link info
      final newLink = ShareLinkInfo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        shareToken: shareToken,
        createdAt: now,
        expiresAt: expiresAt,
      );

      // Update state
      final updatedLinks = [...state.activeLinks, newLink];
      state = state.copyWith(
        isLoading: false,
        shareUrl: 'https://fitkarma.health/s/$shareToken',
        activeLinks: updatedLinks,
      );

      return state.shareUrl;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  /// Revoke a share link
  void revokeLink(String linkId) {
    final updatedLinks = state.activeLinks.map((link) {
      if (link.id == linkId) {
        return ShareLinkInfo(
          id: link.id,
          shareToken: link.shareToken,
          createdAt: link.createdAt,
          expiresAt: link.expiresAt,
          isRevoked: true,
        );
      }
      return link;
    }).toList();

    state = state.copyWith(activeLinks: updatedLinks);
  }

  /// Clear current share URL
  void clearShareUrl() {
    state = state.copyWith(shareUrl: null);
  }
}

/// Provider for share link state
final shareLinkProvider = NotifierProvider<ShareLinkNotifier, ShareLinkState>(
  () {
    return ShareLinkNotifier();
  },
);
