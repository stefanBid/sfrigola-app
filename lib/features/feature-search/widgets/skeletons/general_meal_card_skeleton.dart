import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';

class GeneralMealCardSkeleton extends StatefulWidget {
  const GeneralMealCardSkeleton({super.key});

  @override
  State<GeneralMealCardSkeleton> createState() =>
      _GeneralMealCardSkeletonState();
}

class _GeneralMealCardSkeletonState extends State<GeneralMealCardSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _opacity = Tween<double>(
      begin: 0.3,
      end: 0.55,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Padding(
        padding: AppDesign.paddingSm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.of(context).muted,
                  borderRadius: AppDesign.borderRadiusSm,
                ),
              ),
            ),
            Padding(
              padding: AppDesign.paddingSm.copyWith(top: AppDesign.gapItemSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).muted,
                      borderRadius: AppDesign.borderRadiusXXs,
                    ),
                  ),
                  const SizedBox(height: AppDesign.gapItemXs),
                  Container(
                    height: 10,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).muted,
                      borderRadius: AppDesign.borderRadiusXXs,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
