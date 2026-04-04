import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';

final mapCacheServiceProvider = Provider<MapCacheService>((ref) {
  return MapCacheService();
});

class MapCacheService {
  Future<void> initialize() async {
    try {
      await FMTCObjectBoxBackend().initialise();
      await FMTCStore('fitkarma_maps').manage.create();
    } catch (e) {
      // Silently fail if initialization fails
    }
  }

  Future<void> preCacheHomeRegion({
    required double lat,
    required double lng,
    double radiusKm = 5.0,
    int minZoom = 10,
    int maxZoom = 18,
  }) async {
    try {
      final store = FMTCStore('fitkarma_maps');
      final center = LatLng(lat, lng);
      final region = CircleRegion(center, radiusKm * 1000);
      final downloadable = region.toDownloadable(
        minZoom: minZoom,
        maxZoom: maxZoom,
        options: TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
      );
      store.download.startForeground(
        region: downloadable,
        parallelThreads: 5,
        maxBufferLength: 200,
        skipExistingTiles: true,
      );
    } catch (e) {
      // Silently fail
    }
  }

  Future<double> getCacheSize() async {
    try {
      final store = FMTCStore('fitkarma_maps');
      final stats = await store.stats.all;
      return stats.size / (1024 * 1024);
    } catch (e) {
      return 0;
    }
  }

  Future<void> clearCache() async {
    try {
      final store = FMTCStore('fitkarma_maps');
      await store.manage.reset();
    } catch (e) {
      // Silently fail
    }
  }

  Stream<DownloadProgress>? downloadProgressStream() {
    return null;
  }
}