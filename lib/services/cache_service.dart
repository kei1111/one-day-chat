import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheService {
  CacheService._() {
    customCacheManager = CacheManager(
      Config(
        'customCacheKey',
        maxNrOfCacheObjects: 100,
        stalePeriod: const Duration(days: 30),
      ),
    );
  }

  static final instance = CacheService._();

  late CacheManager customCacheManager;

  clearCustomCache() async {
    await customCacheManager.emptyCache();
  }

  clearAllCache() async {
    await customCacheManager.emptyCache();

    imageCache.clear();
    imageCache.clearLiveImages();
  }

  removeFileFromCache(String cacheKey) async {
    await customCacheManager.removeFile(cacheKey);
  }
}
