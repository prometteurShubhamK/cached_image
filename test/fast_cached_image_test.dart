import 'package:flutter_test/flutter_test.dart';
import 'package:fast_cached_image/src/memory_cache.dart';
import 'dart:typed_data';

void main() {
  test('Memory cache works', () {
    final cache = MemoryCache(maxItems: 1);
    final data = Uint8List.fromList([1]);
    cache.put('a', data);
    expect(cache.get('a'), data);
  });
}
