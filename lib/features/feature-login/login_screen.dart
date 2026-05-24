import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';
import 'package:sfrigola/core/helpers/app_router.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/app_bars/transparent_app_bar.dart';
import 'package:sfrigola/core/layouts/body/minimal_page_layout.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_icon_button.dart';
import 'package:sfrigola/features/feature-login/widget/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocale.getLabels(context);
    final typo = AppTypography.of(context);

    return MinimalPageLayout(
      appBar: TransparentAppBar(
        leading: BaseIconButton(
          color: Colors.white,
          type: IconButtonType.outlined,
          icon: PhosphorIconsRegular.arrowBendUpLeft,
          onPressed: () => AppRouter.goBack(context),
          tooltip: l.tooltipBack,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDesign.gapSectionMd),

          // Logo
          Center(
            child: ClipOval(
              child: Image.asset(
                'assets/sfrigola-logo.png',
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: AppDesign.gapSectionMd),

          // App name
          Center(child: Text('Sfrigola', style: typo.heading1)),

          const SizedBox(height: AppDesign.gapSectionXl),

          const LoginForm(),

          const SizedBox(height: AppDesign.gapSectionSm),

          // Register row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l.loginRegisterPrompt, style: typo.bodySecondary),
              const SizedBox(width: AppDesign.gapInlineXs),
              GestureDetector(
                onTap: () {
                  // TODO: navigate to register screen
                },
                child: Text(
                  l.loginRegisterAction,
                  style: typo.body.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDesign.gapSectionLg),
        ],
      ),
    );
  }
}
