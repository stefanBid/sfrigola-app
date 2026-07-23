import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_image.dart';

enum ImageFilter { none, darken }

enum ImageFit { cover, contain }

class BaseImageContainer extends StatelessWidget {
  final String imageUrl;
  final ImageFilter filter;
  final ImageFit fit;
  final Duration fadeDuration;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  const BaseImageContainer({
    super.key,
    required this.imageUrl,
    this.filter = ImageFilter.none,
    this.fit = ImageFit.cover,
    this.fadeDuration = const Duration(milliseconds: 300),
    this.width,
    this.height,
    this.borderRadius = AppDesign.borderRadiusMd,
  });

  Color? get _overlayColor {
    return switch (filter) {
      ImageFilter.darken => Colors.black.withAlpha(80),
      ImageFilter.none => null,
    };
  }

  BoxFit get _boxFit {
    return switch (fit) {
      ImageFit.cover => BoxFit.cover,
      ImageFit.contain => BoxFit.contain,
    };
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            AppImage.buildImage(
              context,
              imageUrl: imageUrl,
              type: AppImage.getType(imageUrl),
              fit: _boxFit,
              width: width,
              height: height,
              fadeDuration: fadeDuration,
            ),
            if (_overlayColor != null)
              Positioned.fill(child: ColoredBox(color: _overlayColor!)),
          ],
        ),
      ),
    );
  }
}

