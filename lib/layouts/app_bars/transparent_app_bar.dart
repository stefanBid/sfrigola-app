import 'package:flutter/material.dart';

// Project Helpers
import '../../helpers/app_typography.dart';
import '../../helpers/app_design.dart';

class TransparentAppBar extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final Widget? leading;
  final List<Widget>? actions;

  const TransparentAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: kToolbarHeight + 100),
      child: Container(
        color: Colors.transparent,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: AppDesign.paddingLg,
            child: Row(
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
          ),
        ),
      ),
    );
  }
}
