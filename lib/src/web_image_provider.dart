import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebImageProvider extends ImageProvider<WebImageProvider> {
  final String url;

  const WebImageProvider(this.url);

  @override
  Future<WebImageProvider> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture(this);

  @override
  ImageStreamCompleter load(WebImageProvider key, [ImageDecoderCallback? _]) {
    return NetworkImage(url).resolve(ImageConfiguration.empty).completer!;
  }
}
