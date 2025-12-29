import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';

Future<ui.Codec> decodeInIsolate(Uint8List bytes) {
  return compute(_decode, bytes);
}

Future<ui.Codec> _decode(Uint8List bytes) async {
  return ui.instantiateImageCodec(bytes);
}
