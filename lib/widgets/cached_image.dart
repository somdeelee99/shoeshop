import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/constants/app_colors.dart';

/// Cached network image with shimmer placeholder + error fallback.
class AppCachedImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double radius;

  const AppCachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, _) => Shimmer.fromColors(
        baseColor: AppColors.lightGrey,
        highlightColor: Colors.white,
        child: Container(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          color: AppColors.lightGrey,
        ),
      ),
      errorWidget: (context, _, __) => Container(
        width: width,
        height: height,
        color: AppColors.lightGrey,
        alignment: Alignment.center,
        child: Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.textHint,
          size: 28,
        ),
      ),
    );

    if (radius <= 0) return image;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: image,
    );
  }
}
