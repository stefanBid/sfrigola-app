import 'package:flutter/material.dart';

import '../../helpers/app_design.dart';

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
  final List<Widget> children;
  final GridDimensions dimensions;

  const GcGridView({
    super.key,
    required this.children,
    this.dimensions = const GridDimensions(),
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: dimensions.crossAxisCount,
      childAspectRatio: dimensions.childAspectRatio,
      crossAxisSpacing: dimensions.crossAxisSpacing,
      mainAxisSpacing: dimensions.mainAxisSpacing,
      children: children,
    );
  }
}
