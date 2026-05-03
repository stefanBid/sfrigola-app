import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

class BaseBottomSheet {
  const BaseBottomSheet._();

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void show(
    BuildContext context, {
    required Widget child,
    String? title,
    String? subtitle,
    double? heightFactor,
  }) {
    assert(
      heightFactor == null || (heightFactor > 0 && heightFactor <= 1),
      'heightFactor must be in the range (0, 1]',
    );
    ScaffoldMessenger.of(context).clearSnackBars();

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: true,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      useSafeArea: true,
      builder: (_) => _BaseBottomSheetContent(
        title: title,
        subtitle: subtitle,
        heightFactor: heightFactor,
        child: child,
      ),
    );
  }
}

class _BaseBottomSheetContent extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final double? heightFactor;

  const _BaseBottomSheetContent({
    required this.child,
    this.title,
    this.subtitle,
    this.heightFactor,
  });

  @override
  Widget build(BuildContext context) {
    final hasFixedHeight = heightFactor != null;
    final mq = MediaQuery.of(context);
    final availableHeight =
        mq.size.height - mq.viewPadding.top - mq.viewPadding.bottom;
    final resolvedHeight = hasFixedHeight
        ? availableHeight * heightFactor!
        : null;

    Widget header = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Drag handle
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: AppDesign.gapItemMd),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.of(context).muted.withAlpha(80),
              borderRadius: AppDesign.borderRadiusLg,
            ),
          ),
        ),
        if (title != null || subtitle != null) ...[
          const SizedBox(height: AppDesign.gapSectionSm),
          if (title != null)
            Text(title!, style: AppTypography.of(context).heading3),
          if (title != null && subtitle != null)
            const SizedBox(height: AppDesign.gapItemXs),
          if (subtitle != null)
            Text(
              subtitle!,
              style: AppTypography.of(
                context,
              ).bodySecondary.copyWith(color: AppColors.of(context).muted),
            ),
        ],
        const SizedBox(height: AppDesign.gapSectionSm),
      ],
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          width: double.infinity,
          height: resolvedHeight,
          decoration: BoxDecoration(
            color: AppColors.of(context).surface,
            borderRadius: AppDesign.borderRadiusTopMd,
          ),
          child: Padding(
            padding: AppDesign.paddingPage,
            child: Column(
              mainAxisSize: hasFixedHeight
                  ? MainAxisSize.max
                  : MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                if (hasFixedHeight)
                  Expanded(child: SingleChildScrollView(child: child))
                else
                  Flexible(child: SingleChildScrollView(child: child)),
                const SizedBox(height: AppDesign.gapSectionSm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
