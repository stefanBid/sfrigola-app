import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';

/// Animated skeleton for a section header (title + subtitle).
class SkeletonHeader extends StatefulWidget {
  const SkeletonHeader({super.key});

  @override
  State<SkeletonHeader> createState() => _SkeletonHeaderState();
}

class _SkeletonHeaderState extends State<SkeletonHeader>
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.of(context).muted,
              borderRadius: AppDesign.borderRadiusXXs,
            ),
          ),
          const SizedBox(height: AppDesign.gapInlineXs),
          Container(
            width: 220,
            height: 14,
            decoration: BoxDecoration(
              color: AppColors.of(context).muted,
              borderRadius: AppDesign.borderRadiusXXs,
            ),
          ),
        ],
      ),
    );
  }
}
