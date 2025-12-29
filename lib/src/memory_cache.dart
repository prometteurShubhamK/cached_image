import 'dart:collection';
import 'dart:typed_data';

class MemoryCache {
  final int maxItems;
  final _map = LinkedHashMap<String, Uint8List>();

  MemoryCache({this.maxItems = 100});

  Uint8List? get(String key) {
    final value = _map.remove(key);
    if (value != null) _map[key] = value;
    return value;
  }

  void put(String key, Uint8List value) {
    if (_map.length >= maxItems) {
      _map.remove(_map.keys.first);
    }
    _map[key] = value;
  }

  void clear() => _map.clear();
}
