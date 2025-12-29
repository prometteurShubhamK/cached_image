import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class CacheManager {
  Future<Directory> _dir() async {
    final base = await getTemporaryDirectory();
    final dir = Directory('${base.path}/fast_cached_image');
    if (!dir.existsSync()) dir.createSync(recursive: true);
    return dir;
  }

  String _key(String url) =>
      sha1.convert(utf8.encode(url)).toString();

  Future<Uint8List?> get(String url, Duration maxAge) async {
    final file = File('${(await _dir()).path}/${_key(url)}');
    if (!file.existsSync()) return null;

    if (DateTime.now()
            .difference(file.lastModifiedSync()) >
        maxAge) {
      file.deleteSync();
      return null;
    }
    return file.readAsBytes();
  }

  Future<void> put(String url, Uint8List bytes) async {
    final file = File('${(await _dir()).path}/${_key(url)}');
    await file.writeAsBytes(bytes, flush: true);
  }

  Future<void> clear() async {
    final dir = await _dir();
    if (dir.existsSync()) dir.deleteSync(recursive: true);
  }
}
