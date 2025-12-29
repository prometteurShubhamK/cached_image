import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'cache_manager.dart';
import 'memory_cache.dart';
import 'network_loader.dart';
import 'isolate_decoder.dart';
import 'web_image_provider.dart';

class FastCachedImageProvider
    extends ImageProvider<FastCachedImageProvider> {
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
  Future<ImageStreamCompleter> load(
      FastCachedImageProvider key, DecoderCallback decode) async {
    final bytes = await _loadBytes();
    final codec = await decodeInIsolate(bytes);
    return OneFrameImageStreamCompleter(codec);
  }

  Future<Uint8List> _loadBytes() async {
    final mem = _memory.get(url);
    if (mem != null) return mem;

    final disk = await _disk.get(url, cacheDuration);
    if (disk != null) {
      _memory.put(url, disk);
      return disk;
    }

    final bytes = await _loader.fetch(url);
    _memory.put(url, bytes);
    await _disk.put(url, bytes);
    return bytes;
  }

  @override
  Future<FastCachedImageProvider> obtainKey(
          ImageConfiguration configuration) =>
      SynchronousFuture(this);

  @override
  bool operator ==(Object other) =>
      other is FastCachedImageProvider && other.url == url;

  @override
  int get hashCode => url.hashCode;
}

ImageProvider platformImageProvider(String url) {
  if (kIsWeb) return WebImageProvider(url);
  return FastCachedImageProvider(url);
}
