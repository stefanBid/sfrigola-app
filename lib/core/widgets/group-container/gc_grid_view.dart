import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';

class GridDimensions {
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const GridDimensions({
    this.crossAxisCount = 2,
    this.childAspectRatio = 3 / 2,
    this.crossAxisSpacing = AppDesign.gapItemMd,
    this.mainAxisSpacing = AppDesign.gapItemMd,
  });
}

class GcGridView extends StatelessWidget {
  final ScrollController? scrollController;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final GridDimensions dimensions;

  const GcGridView({
    super.key,
    this.scrollController,
    required this.itemCount,
    required this.itemBuilder,
    this.dimensions = const GridDimensions(),
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: dimensions.crossAxisCount,
        childAspectRatio: dimensions.childAspectRatio,
        crossAxisSpacing: dimensions.crossAxisSpacing,
        mainAxisSpacing: dimensions.mainAxisSpacing,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
