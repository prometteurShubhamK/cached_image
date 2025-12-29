import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class WebImageProvider extends ImageProvider<WebImageProvider> {
  final String url;

  const WebImageProvider(this.url);

  @override
  ImageStreamCompleter load(
      WebImageProvider key, DecoderCallback decode) {
    return NetworkImage(url)
        .resolve(ImageConfiguration.empty)
        .completer!;
  }

  @override
  Future<WebImageProvider> obtainKey(
          ImageConfiguration configuration) =>
      SynchronousFuture(this);
}
