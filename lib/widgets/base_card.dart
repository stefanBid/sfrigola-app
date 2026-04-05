import 'package:flutter/material.dart';

// Project Helpers
import '../helpers/app_colors.dart';
import '../helpers/app_design.dart';
import '../helpers/app_typography.dart';

// Project Widgets
import 'base_image_container.dart';

class BaseCard extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const BaseCard({
    super.key,
    required this.title,
    required this.content,
    required this.imageUrl,
    this.width = 220,
    this.height = 220,
    this.padding = EdgeInsets.zero,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: width,
        height: height,
        child: Material(
          borderRadius: AppDesign.borderRadiusMd,
          color: Colors.transparent,
          child: InkWell(
            splashColor: AppColors.of(context).text.withAlpha(60),
            highlightColor: AppColors.of(context).text.withAlpha(30),
            borderRadius: AppDesign.borderRadiusMd,
            onTap: onTap,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: AppDesign.borderRadiusMd,
                color: AppColors.of(context).surface,
              ),
              padding: AppDesign.paddingSm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BaseImageContainer(
                      imageUrl: imageUrl,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: AppDesign.paddingSm.copyWith(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography.of(
                            context,
                          ).body.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppDesign.gapItemXs),
                        Text(
                          content,
                          style: AppTypography.of(context).caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
