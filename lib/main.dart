import 'package:flutter/material.dart';
import 'package:fast_cached_image/fast_cached_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Fast Cached Image')),
        body: Center(
          child: FastCachedImage(
            imageUrl: 'https://picsum.photos/400',
          ),
        ),
      ),
    );
  }
}
