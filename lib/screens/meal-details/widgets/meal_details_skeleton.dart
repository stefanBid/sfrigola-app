import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_router.dart';

// Project Layouts
import 'package:sfrigola/layouts/app_bars/transparent_app_bar.dart';

// Project Widgets
import 'package:sfrigola/widgets/base_icon_button.dart';

class MealDetailsSkeleton extends StatefulWidget {
  const MealDetailsSkeleton({super.key});

  @override
  State<MealDetailsSkeleton> createState() => _MealDetailsSkeletonState();
}

class _MealDetailsSkeletonState extends State<MealDetailsSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _opacity = Tween<double>(
      begin: 0.25,
      end: 0.65,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    Widget block({double? width, required double height}) {
      return AnimatedBuilder(
        animation: _opacity,
        builder: (context, _) => Container(
          width: width ?? double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.of(
              context,
            ).muted.withAlpha((_opacity.value * 255).round()),
            borderRadius: AppDesign.borderRadiusXXs,
          ),
        ),
      );
    }

    Widget line({required double widthFactor, required double height}) {
      return FractionallySizedBox(
        widthFactor: widthFactor,
        child: block(height: height),
      );
    }

    return Stack(
      children: [
        // — Image placeholder
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: screenHeight * 0.35,
          child: ColoredBox(color: AppColors.of(context).surface),
        ),

        // — Content container
        Positioned(
          top: screenHeight * 0.35 - 48,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: AppDesign.borderRadiusTopLg,
              color: AppColors.of(context).background,
            ),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              padding: AppDesign.paddingXl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  line(widthFactor: 0.75, height: 28),
                  const SizedBox(height: AppDesign.gapItemXs),
                  // Subtitle
                  line(widthFactor: 0.55, height: 16),
                  const SizedBox(height: AppDesign.gapSectionSm),

                  // Stats chips row
                  Row(
                    children: [
                      block(width: 72, height: 28),
                      const SizedBox(width: AppDesign.gapInlineSm),
                      block(width: 80, height: 28),
                      const SizedBox(width: AppDesign.gapInlineSm),
                      block(width: 90, height: 28),
                      const SizedBox(width: AppDesign.gapInlineSm),
                      block(width: 76, height: 28),
                    ],
                  ),
                  const SizedBox(height: AppDesign.gapSectionMd),

                  // Description section
                  line(widthFactor: 0.35, height: 18),
                  const SizedBox(height: AppDesign.gapItemSm),
                  line(widthFactor: 1.0, height: 14),
                  const SizedBox(height: AppDesign.gapItemXs),
                  line(widthFactor: 0.95, height: 14),
                  const SizedBox(height: AppDesign.gapItemXs),
                  line(widthFactor: 1.0, height: 14),
                  const SizedBox(height: AppDesign.gapItemXs),
                  line(widthFactor: 0.80, height: 14),
                  const SizedBox(height: AppDesign.gapSectionMd),

                  // Ingredients section
                  line(widthFactor: 0.40, height: 18),
                  const SizedBox(height: AppDesign.gapItemSm),
                  line(widthFactor: 0.55, height: 14),
                  const SizedBox(height: AppDesign.gapItemXs),
                  line(widthFactor: 0.65, height: 14),
                  const SizedBox(height: AppDesign.gapItemXs),
                  line(widthFactor: 0.50, height: 14),
                  const SizedBox(height: AppDesign.gapItemXs),
                  line(widthFactor: 0.70, height: 14),
                  const SizedBox(height: AppDesign.gapItemXs),
                  line(widthFactor: 0.60, height: 14),
                  const SizedBox(height: AppDesign.gapItemXs),
                  line(widthFactor: 0.58, height: 14),
                  const SizedBox(height: AppDesign.gapSectionMd),

                  // Steps section
                  line(widthFactor: 0.30, height: 18),
                  const SizedBox(height: AppDesign.gapItemSm),
                  for (int i = 0; i < 4; i++) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        block(width: 24, height: 24),
                        const SizedBox(width: AppDesign.gapInlineSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              block(height: 14),
                              const SizedBox(height: AppDesign.gapItemXs),
                              line(widthFactor: 0.70, height: 14),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (i < 3) const SizedBox(height: AppDesign.gapItemSm),
                  ],
                ],
              ),
            ),
          ),
        ),

        // — Transparent app bar with back button
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: TransparentAppBar(
            leading: BaseIconButton(
              color: Colors.white,
              type: IconButtonType.outlined,
              icon: PhosphorIconsRegular.arrowBendUpLeft,
              onPressed: () => AppRouter.goBack(context),
              tooltip: 'Back',
            ),
          ),
        ),
      ],
    );
  }
}
