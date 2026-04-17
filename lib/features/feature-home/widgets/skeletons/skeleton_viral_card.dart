import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';

/// Animated skeleton for a single viral (wide) meal card — 320×280.
/// Use as the last item of a horizontal infinite scroll list.
class SkeletonViralCard extends StatefulWidget {
  const SkeletonViralCard({super.key});

  @override
  State<SkeletonViralCard> createState() => _SkeletonViralCardState();
}

class _SkeletonViralCardState extends State<SkeletonViralCard>
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
        padding: AppDesign.paddingHorizontalLg.copyWith(left: 0),
        child: SizedBox(
          width: 320,
          height: 280,
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
                  padding: AppDesign.paddingSm.copyWith(
                    top: AppDesign.gapItemSm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 180,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.of(context).muted,
                          borderRadius: AppDesign.borderRadiusXXs,
                        ),
                      ),
                      const SizedBox(height: AppDesign.gapItemXs),
                      Container(
                        width: 120,
                        height: 10,
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
        ),
      ),
    );
  }
}
