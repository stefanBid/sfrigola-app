import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Projects Helpers
import '../helpers/app_design.dart';
import '../helpers/app_colors.dart';

enum ImageFilter { none, darken }

enum ImageFit { cover, contain }

enum ImageType { network, asset }

class BaseImageContainer extends StatelessWidget {
  final String imageUrl;
  final ImageFilter filter;
  final ImageFit fit;
  final ImageType type;
  final Duration fadeDuration;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  const BaseImageContainer({
    super.key,
    required this.imageUrl,
    this.filter = ImageFilter.none,
    this.fit = ImageFit.cover,
    this.type = ImageType.network,
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

  Widget _buildImage(BuildContext context) {
    switch (type) {
      case ImageType.network:
        return CachedNetworkImage(
          imageUrl: imageUrl,
          fit: _boxFit,
          width: width,
          height: height,
          fadeInDuration: fadeDuration,
          placeholder: (context, url) => const SizedBox.shrink(),
          errorWidget: (context, url, error) => Container(
            color: AppColors.of(context).muted,
            child: Icon(
              Icons.broken_image,
              size: 40,
              color: AppColors.of(context).text.withAlpha(120),
            ),
          ),
        );
      case ImageType.asset:
        return Image.asset(
          imageUrl,
          fit: _boxFit,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.of(context).muted,
            child: Icon(
              Icons.broken_image,
              size: 40,
              color: AppColors.of(context).text.withAlpha(120),
            ),
          ),
        );
    }
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
            _buildImage(context),
            if (_overlayColor != null)
              Positioned.fill(child: ColoredBox(color: _overlayColor!)),
          ],
        ),
      ),
    );
  }
}
