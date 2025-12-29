import 'dart:typed_data';
import 'dart:ui' as ui; // Needed for Codec & instantiateImageCodec
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'cache_manager.dart';
import 'memory_cache.dart';
import 'network_loader.dart';

class FastCachedImageProvider extends ImageProvider<FastCachedImageProvider> {
  final String url;
  final Duration cacheDuration;

  static final _memory = MemoryCache();
  static final _disk = CacheManager();
  static final _loader = NetworkLoader();

  const FastCachedImageProvider(
    this.url, {
    this.cacheDuration = const Duration(days: 7),
  });

  @override
  Future<FastCachedImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(this);
  }

  @override
  ImageStreamCompleter load(FastCachedImageProvider key, [ImageDecoderCallback? _]) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(),
      scale: 1.0,
    );
  }

  Future<ui.Codec> _loadAsync() async {
    final bytes = await _loadBytes();
    return await ui.instantiateImageCodec(bytes);
  }

  Future<Uint8List> _loadBytes() async {
    // Check memory cache
    final mem = _memory.get(url);
    if (mem != null) return mem;

    // Check disk cache
    final disk = await _disk.get(url, cacheDuration);
    if (disk != null) {
      _memory.put(url, disk);
      return disk;
    }

    // Fetch from network
    final bytes = await _loader.fetch(url);
    _memory.put(url, bytes);
    await _disk.put(url, bytes);
    return bytes;
  }

  @override
  bool operator ==(Object other) =>
      other is FastCachedImageProvider && other.url == url;

  @override
  int get hashCode => url.hashCode;
}
