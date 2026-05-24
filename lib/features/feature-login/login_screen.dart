import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';
import 'package:sfrigola/core/helpers/app_validation.dart';
import 'package:sfrigola/core/helpers/app_router.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/app_bars/transparent_app_bar.dart';
import 'package:sfrigola/core/layouts/body/minimal_page_layout.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_button.dart';
import 'package:sfrigola/core/widgets/base_icon_button.dart';
import 'package:sfrigola/core/widgets/base_form_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      // TODO: trigger login provider
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocale.getLabels(context);
    final colors = AppColors.of(context);
    final typo = AppTypography.of(context);

    return MinimalPageLayout(
      appBar: TransparentAppBar(
        leading: BaseIconButton(
          color: Colors.white,
          type: IconButtonType.outlined,
          icon: PhosphorIconsRegular.arrowBendUpLeft,
          onPressed: () => AppRouter.goBack(context),
          tooltip: AppLocale.getLabels(context).tooltipBack,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
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

            const SizedBox(height: 48),

            // Email
            BaseFormField(
              controller: _emailController,
              label: l.loginEmailLabel,
              hint: l.loginEmailHint,
              prefixIcon: PhosphorIconsRegular.envelope,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (v) =>
                  AppValidation.notEmpty(v, message: l.loginEmailRequired) ??
                  AppValidation.email(v, message: l.loginEmailInvalid),
            ),

            const SizedBox(height: AppDesign.gapSectionSm),

            // Password
            BaseFormField(
              controller: _passwordController,
              label: l.loginPasswordLabel,
              hint: l.loginPasswordHint,
              prefixIcon: PhosphorIconsRegular.lockKey,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _onLogin(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? PhosphorIconsRegular.eye
                      : PhosphorIconsRegular.eyeSlash,
                  size: AppDesign.iconSizeMd,
                  color: colors.muted,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              validator: (v) =>
                  AppValidation.notEmpty(v, message: l.loginPasswordRequired),
            ),

            const SizedBox(height: AppDesign.gapSectionMd),

            // Login button
            BaseButton(
              label: l.loginButton,
              type: BaseButtonType.filled,
              fullWidth: true,
              onPressed: _onLogin,
            ),

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
      ),
    );
  }
}
