import 'package:flutter/material.dart';

// Project Helpers
import '../../helpers/app_colors.dart';
import '../../helpers/app_typography.dart';
import '../../helpers/app_design.dart';

class ClassicAppBar extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? bottomContent;

  const ClassicAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.leading,
    this.actions,
    this.bottomContent,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: kToolbarHeight + 100),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.of(context).background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: AppDesign.paddingLg,
            child: Column(
              children: [
                Row(
                  children: [
                    if (leading != null) ...[
                      leading!,
                      const SizedBox(width: AppDesign.gapInlineSm),
                    ],
                    Expanded(
                      child: Text(
                        title ?? '',
                        style: titleStyle ?? AppTypography.of(context).heading2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (actions != null)
                      Row(mainAxisSize: MainAxisSize.min, children: actions!),
                  ],
                ),
                if (bottomContent != null) ...[
                  const SizedBox(height: AppDesign.gapSectionSm),
                  bottomContent!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
