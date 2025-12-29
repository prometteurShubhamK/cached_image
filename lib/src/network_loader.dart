import 'dart:typed_data';
import 'package:http/http.dart' as http;

class NetworkLoader {
  Future<Uint8List> fetch(String url) async {
    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      throw Exception('Download failed');
    }
    return res.bodyBytes;
  }
}
