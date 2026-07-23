// * ════════════════════════════════════════════════════════════════════════════
// *  APP IMAGE
// * ════════════════════════════════════════════════════════════════════════════
// *
// *  Image utility helper. Resolves the source type from a URL/path and builds
// *  the appropriate image widget (network, asset or local file).
// *
// *  AppImage.getType(url)      → ImageType
// *  AppImage.buildImage(...)   → Widget
// *
// * ════════════════════════════════════════════════════════════════════════════

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';

enum ImageType { network, asset, file }

class AppImage {
  AppImage._();

  static ImageType getType(String imageUrl) {
    if (imageUrl.startsWith('http')) return ImageType.network;
    if (imageUrl.startsWith('assets/')) return ImageType.asset;
    return ImageType.file;
  }

  static Widget buildImage(
    BuildContext context, {
    required String imageUrl,
    required ImageType type,
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    Duration fadeDuration = const Duration(milliseconds: 300),
  }) {
    return switch (type) {
      ImageType.network => CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        width: width,
        height: height,
        fadeInDuration: fadeDuration,
        placeholder: (context, url) => const SizedBox.shrink(),
        errorWidget: (context, url, error) => _errorFallback(context),
      ),
      ImageType.asset => Image.asset(
        imageUrl,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) => _errorFallback(context),
      ),
      ImageType.file => Image.file(
        File(imageUrl),
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) => _errorFallback(context),
      ),
    };
  }

  static Widget _errorFallback(BuildContext context) => Container(
    color: AppColors.of(context).muted,
    child: Icon(
      LucideIcons.imageOff,
      size: AppDesign.iconSizeXl,
      color: AppColors.of(context).text.withAlpha(120),
    ),
  );
}

