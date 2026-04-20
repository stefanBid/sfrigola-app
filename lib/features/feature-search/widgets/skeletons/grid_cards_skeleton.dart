import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';

/// Full-grid animated skeleton for the search screen.
/// A single [AnimationController] drives all cards — they all pulse in sync.
class GridCardsSkeleton extends StatefulWidget {
  const GridCardsSkeleton({super.key});

  @override
  State<GridCardsSkeleton> createState() => _GridCardsSkeletonState();
}

class _GridCardsSkeletonState extends State<GridCardsSkeleton>
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

  Widget _buildCard(BuildContext context) {
    return Container(
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
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.of(context).muted,
                    borderRadius: AppDesign.borderRadiusXXs,
                  ),
                ),
                const SizedBox(height: AppDesign.gapItemXs),
                Wrap(
                  spacing: AppDesign.gapInlineSm,
                  runSpacing: AppDesign.gapInlineSm,
                  children: [
                    _buildBadge(context, 64),
                    _buildBadge(context, 72),
                    _buildBadge(context, 80),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(BuildContext context, double width) {
    return Container(
      width: width,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.of(context).muted,
        borderRadius: AppDesign.borderRadiusXXs,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = AppDesign.isTablet(context);
    final columns = isTablet ? 2 : 1;
    final cardCount = isTablet ? 4 : 5;

    return FadeTransition(
      opacity: _opacity,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: AppDesign.gapItemMd,
          mainAxisSpacing: AppDesign.gapItemMd,
          mainAxisExtent: 300,
        ),
        itemCount: cardCount,
        itemBuilder: (context, _) => _buildCard(context),
      ),
    );
  }
}
