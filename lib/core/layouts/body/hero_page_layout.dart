import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import '../../helpers/app_colors.dart';
import '../../helpers/app_design.dart';
import '../../helpers/app_router.dart';

// Project Widgets
import '../../widgets/base_image_container.dart';
import '../../widgets/base_icon_button.dart';

// Project Layouts
import '../app_bars/transparent_app_bar.dart';

class HeroPageLayout extends StatelessWidget {
  /// When null, a muted placeholder is shown instead of the hero image
  /// (used for loading and error states).
  final String? imageUrl;
  final double imageHeight;
  final Widget body;
  final List<Widget>? actions;
  final VoidCallback? onBack;

  const HeroPageLayout({
    super.key,
    this.imageUrl,
    required this.body,
    this.imageHeight = 280,
    this.onBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: screenHeight * 0.35,
          child: imageUrl != null
              ? BaseImageContainer(
                  imageUrl: imageUrl!,
                  filter: ImageFilter.darken,
                  borderRadius: BorderRadius.zero,
                )
              : ColoredBox(color: AppColors.of(context).muted),
        ),
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
              padding: AppDesign.paddingXl,
              child: body,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: TransparentAppBar(
            actions: actions,
            leading: BaseIconButton(
              color: Colors.white,
              type: IconButtonType.outlined,
              icon: PhosphorIconsRegular.arrowBendUpLeft,
              onPressed: onBack ?? () => AppRouter.goBack(context),
              tooltip: 'Back',
            ),
          ),
        ),
      ],
    );
  }
}
