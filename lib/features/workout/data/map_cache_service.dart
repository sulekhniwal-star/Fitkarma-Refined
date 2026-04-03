import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';

final mapCacheServiceProvider = Provider<MapCacheService>((ref) {
  return MapCacheService();
});

class MapCacheService {
  static const double _defaultZoom = 15.0;
  static const int _defaultMinZoom = 10;
  static const int _defaultMaxZoom = 18;

  Future<void> initialize() async {
    await FMTCObjectBoxBackend().initialise();
    await FMTCStore('fitkarma_maps').manage.create();
  }

  Future<void> preCacheHomeRegion({
    required double lat,
    required double lng,
    double radiusKm = 5.0,
    int minZoom = _defaultMinZoom,
    int maxZoom = _defaultMaxZoom,
  }) async {
    final store = FMTCStore('fitkarma_maps');
    
    final center = LatLng(lat, lng);

    final downloadableRegion = CircleRegion(center, radiusKm * 1000);

    await store.download.startForeground(
      region: downloadableRegion,
      parallelThreads: 5,
      maxBufferLength: 200,
      skipExistingTiles: true,
    );
  }

  Future<double> getCacheSize() async {
    final store = FMTCStore('fitkarma_maps');
    final stats = await store.stats;
    return stats.size / (1024 * 1024);
  }

  Future<void> clearCache() async {
    final store = FMTCStore('fitkarma_maps');
    await store.manage.reset();
  }

  Stream<DownloadProgress> get downloadProgressStream => 
      FMTCStore('fitkarma_maps').download;
}