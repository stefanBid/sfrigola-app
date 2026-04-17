import 'package:flutter/material.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_image_container.dart';

class GeneralMealCard extends StatelessWidget {
  final MealPreview meal;
  final EdgeInsetsGeometry padding;
  final void Function(String mealId) onTap;

  const GeneralMealCard({
    super.key,
    required this.meal,
    required this.onTap,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Material(
          color: Colors.transparent,
          borderRadius: AppDesign.borderRadiusMd,
          child: InkWell(
            splashColor: AppColors.of(context).text.withAlpha(60),
            highlightColor: AppColors.of(context).text.withAlpha(30),
            borderRadius: AppDesign.borderRadiusMd,
            onTap: () => onTap(meal.id),
            child: Ink(
              decoration: const BoxDecoration(
                borderRadius: AppDesign.borderRadiusMd,
                color: Colors.transparent,
              ),
              padding: AppDesign.paddingSm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BaseImageContainer(
                      imageUrl: meal.imageUrl,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: AppDesign.paddingSm.copyWith(
                      top: AppDesign.gapItemSm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.title,
                          style: AppTypography.of(
                            context,
                          ).body.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppDesign.gapItemXs),
                        Text(
                          meal.subtitle,
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
