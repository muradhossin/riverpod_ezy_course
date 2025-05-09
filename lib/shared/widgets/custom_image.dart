import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String? imagePath;
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const CustomImage({super.key, this.imagePath, this.imageUrl, this.height = 100, this.width = 100, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        height: height,
        width: width,
        fit: fit,
        imageUrl: imageUrl!,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
      );
    } else {
      return imagePath != null ? Image.asset(imagePath!, height: height, width: width, fit: fit) : const Center(child: Icon(Icons.error));
    }
  }
}

