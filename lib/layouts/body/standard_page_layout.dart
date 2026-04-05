import 'package:flutter/material.dart';

// Project Helpers
import '../../helpers/app_colors.dart';
import '../../helpers/app_design.dart';

class StandardPageLayout extends StatelessWidget {
  final Widget? appBar;
  final Widget body;
  final bool hasPadding;

  const StandardPageLayout({
    super.key,
    required this.body,
    this.appBar,
    this.hasPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ?appBar,
        Expanded(
          child: Container(
            padding: hasPadding ? AppDesign.paddingPage : EdgeInsets.zero,
            decoration: BoxDecoration(color: AppColors.of(context).background),
            child: body,
          ),
        ),
      ],
    );
  }
}
