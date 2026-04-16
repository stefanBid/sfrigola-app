import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';

// Project Widgets
import 'package:sfrigola/widgets/group-container/gc_list_view.dart';

/// Animated skeleton row for standard (square) meal cards — horizontal scroll.
class SkeletonCardRow extends StatefulWidget {
  const SkeletonCardRow({super.key});

  @override
  State<SkeletonCardRow> createState() => _SkeletonCardRowState();
}

class _SkeletonCardRowState extends State<SkeletonCardRow>
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

  Widget _buildCard(BuildContext context, int index) {
    return Padding(
      padding: AppDesign.paddingHorizontalLg.copyWith(
        left: index == 0 ? AppDesign.paddingHorizontalLg.left : 0,
      ),
      child: Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          color: AppColors.of(context).surface,
          borderRadius: AppDesign.borderRadiusMd,
        ),
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
                    width: 130,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).muted,
                      borderRadius: AppDesign.borderRadiusXXs,
                    ),
                  ),
                  const SizedBox(height: AppDesign.gapItemXs),
                  Container(
                    width: 90,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: GcListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: _buildCard,
      ),
    );
  }
}
