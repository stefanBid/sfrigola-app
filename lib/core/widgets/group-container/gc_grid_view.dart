import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';

class GridDimensions {
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double? mainAxisExtent;
  final double? maxItemWidth;
  final EdgeInsetsGeometry padding;

  const GridDimensions({
    this.crossAxisCount = 2,
    this.childAspectRatio = 3 / 2,
    this.crossAxisSpacing = AppDesign.gapItemMd,
    this.mainAxisSpacing = AppDesign.gapItemMd,
    this.mainAxisExtent,
    this.maxItemWidth,
    this.padding = EdgeInsets.zero,
  });

  double? get maxGridWidth => maxItemWidth == null
      ? null
      : maxItemWidth! * crossAxisCount +
            crossAxisSpacing * (crossAxisCount - 1);
}

class GcGridView extends StatelessWidget {
  final ScrollController? scrollController;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final GridDimensions dimensions;
  final ScrollPhysics? physics;

  const GcGridView({
    super.key,
    this.scrollController,
    required this.itemCount,
    required this.itemBuilder,
    this.dimensions = const GridDimensions(),
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    final maxGridWidth = dimensions.maxGridWidth;
    final grid = GridView.builder(
      controller: scrollController,
      physics: physics,
      padding: dimensions.padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: dimensions.crossAxisCount,
        childAspectRatio: dimensions.childAspectRatio,
        crossAxisSpacing: dimensions.crossAxisSpacing,
        mainAxisSpacing: dimensions.mainAxisSpacing,
        mainAxisExtent: dimensions.mainAxisExtent,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );

    if (maxGridWidth == null) return grid;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxGridWidth),
        child: grid,
      ),
    );
  }
}
