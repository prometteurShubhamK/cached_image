# fast_cached_image

Fast, lightweight Flutter package for loading network images with memory and disk caching.

## Features
- Memory LRU cache
- Disk cache with TTL
- Web support
- Isolate image decoding
- Background prefetch
- ImageProvider support
- Retry & fade animation
- CI ready

## Usage

```dart
FastCachedImage(imageUrl: url);
