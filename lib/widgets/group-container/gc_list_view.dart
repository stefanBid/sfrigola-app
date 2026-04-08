import 'package:flutter/material.dart';

class GcListView extends StatelessWidget {
  final Widget? Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final Axis scrollDirection;
  final ScrollPhysics physics;
  final EdgeInsetsGeometry? padding;

  const GcListView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.scrollDirection = Axis.vertical,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      physics: physics,
      padding: padding,
      itemCount: itemCount < 0 ? 0 : itemCount,
      itemBuilder: (context, index) =>
          itemBuilder(context, index) ?? const SizedBox.shrink(),
    );
  }
}
