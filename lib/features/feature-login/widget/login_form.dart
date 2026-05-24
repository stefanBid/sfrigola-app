import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Providers
import 'package:sfrigola/core/providers/current_user_provider.dart';
import 'package:sfrigola/features/feature-login/providers/login_provider.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_router.dart';
import 'package:sfrigola/core/helpers/app_validation.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_button.dart';
import 'package:sfrigola/core/widgets/base_scaffold_messenger.dart';
import 'package:sfrigola/core/widgets/base_form_field.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
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
      ref
          .read(loginProvider.notifier)
          .login(_emailController.text.trim(), _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocale.getLabels(context);
    final colors = AppColors.of(context);

    final loginOP = ref.watch(loginProvider);

    ref.listen(loginProvider, (previous, next) {
      if (!mounted) return;
      if (next is AsyncError) {
        BaseScaffoldMessenger.show(
          context,
          duration: const Duration(seconds: 3),
          message: AppLocale.errorFor(context, next.error),
          type: SnackBarType.error,
        );
        return;
      }
      if (next is AsyncData && previous is AsyncLoading) {
        ref.invalidate(currentUserProvider);
        AppRouter.goTo(context, AppRouter.home);
      }
    });

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email
          BaseFormField(
            controller: _emailController,
            label: l.loginEmailLabel,
            hint: l.loginEmailHint,
            prefixIcon: PhosphorIconsRegular.envelope,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteractionIfError,
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
            autovalidateMode: AutovalidateMode.onUserInteractionIfError,
            validator: (v) =>
                AppValidation.notEmpty(v, message: l.loginPasswordRequired),
          ),

          const SizedBox(height: AppDesign.gapSectionMd),

          // Login button
          BaseButton(
            label: l.loginButton,
            type: BaseButtonType.filled,
            fullWidth: true,
            isLoading: loginOP.isLoading,
            onPressed: _onLogin,
          ),
        ],
      ),
    );
  }
}
