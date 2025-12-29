import 'cache_manager.dart';
import 'memory_cache.dart';
import 'network_loader.dart';

class ImagePrefetcher {
  static final _disk = CacheManager();
  static final _memory = MemoryCache();
  static final _loader = NetworkLoader();

  static Future<void> prefetch(String url) async {
    if (_memory.get(url) != null) return;

    final disk = await _disk.get(
        url, const Duration(days: 7));
    if (disk != null) {
      _memory.put(url, disk);
      return;
    }

    final bytes = await _loader.fetch(url);
    _memory.put(url, bytes);
    await _disk.put(url, bytes);
  }
}
