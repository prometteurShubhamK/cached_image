import 'package:flutter/material.dart';
import 'network_image_provider.dart';

class FastCachedImage extends StatelessWidget {
  final String imageUrl;
  final Widget? errorWidget;

  const FastCachedImage({
    super.key,
    required this.imageUrl,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: FastCachedImageProvider(imageUrl),
      frameBuilder: (context, child, frame, _) {
        if (frame != null) {
          return AnimatedOpacity(
            opacity: 1,
            duration: const Duration(milliseconds: 300),
            child: child,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (_, __, ___) =>
          errorWidget ?? const Icon(Icons.error),
    );
  }
}
