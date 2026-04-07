import 'package:flutter/material.dart';

// Project Models
import 'package:sfrigola/models/meal.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/widgets/base_image_container.dart';

class ViralMealCard extends StatelessWidget {
  final Meal meal;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final void Function(String mealId) onTap;

  const ViralMealCard({
    super.key,
    required this.meal,
    required this.onTap,
    this.width = 320,
    this.height = 280,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: width,
        height: height,
        child: Container(color: AppColors.of(context).surface),
      ),
    );
  }
}
