import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';
import 'package:sfrigola/core/helpers/app_validation.dart';

// Project Providers
import 'package:sfrigola/core/providers/current_user_provider.dart';
import 'package:sfrigola/core/providers/repository_provider.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_bottom_sheet.dart';
import 'package:sfrigola/core/widgets/base_button.dart';
import 'package:sfrigola/core/widgets/base_checkbox.dart';
import 'package:sfrigola/core/widgets/base_form_field.dart';
import 'package:sfrigola/core/widgets/base_scaffold_messenger.dart';

class ProfileChangePasswordSection extends StatelessWidget {
  const ProfileChangePasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocale.getLabels(context);
    final colors = AppColors.of(context);

    return InkWell(
      onTap: () => BaseBottomSheet.show(
        context,
        title: l.profileChangePassword,
        child: const _ChangePasswordForm(),
      ),
      borderRadius: AppDesign.borderRadiusXs,
      child: Padding(
        padding: AppDesign.paddingSymmetricMd,
        child: Row(
          children: [
            Icon(
              LucideIcons.lock,
              size: AppDesign.iconSizeMd,
              color: colors.muted,
            ),
            const SizedBox(width: AppDesign.gapInlineSm),
            Expanded(
              child: Text(
                l.profileChangePassword,
                style: AppTypography.of(context).body,
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: AppDesign.iconSizeSm,
              color: colors.muted,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangePasswordForm extends ConsumerStatefulWidget {
  const _ChangePasswordForm();

  @override
  ConsumerState<_ChangePasswordForm> createState() =>
      _ChangePasswordFormState();
}

class _ChangePasswordFormState extends ConsumerState<_ChangePasswordForm> {
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _logoutCurrentDevice = false;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .changePassword(
            _currentPasswordController.text,
            _newPasswordController.text,
          );
      if (!mounted) return;

      BaseScaffoldMessenger.show(
        context,
        message: AppLocale.getLabels(context).profileChangePasswordSuccess,
        type: SnackBarType.success,
      );

      if (_logoutCurrentDevice) {
        await ref.read(authRepositoryProvider).logout();
        ref.invalidate(currentUserProvider);
        if (mounted) context.go('/login');
        return;
      }

      BaseBottomSheet.hide(context);
    } catch (e) {
      if (!mounted) return;
      BaseScaffoldMessenger.show(
        context,
        message: AppLocale.errorFor(context, e),
        type: SnackBarType.error,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocale.getLabels(context);
    final colors = AppColors.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseFormField(
            controller: _currentPasswordController,
            label: l.profileCurrentPasswordLabel,
            prefixIcon: LucideIcons.lock,
            obscureText: _obscureCurrent,
            textInputAction: TextInputAction.next,
            fillColor: colors.background,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureCurrent
                    ? LucideIcons.eye
                    : LucideIcons.eyeOff,
                size: AppDesign.iconSizeMd,
                color: colors.muted,
              ),
              onPressed: () =>
                  setState(() => _obscureCurrent = !_obscureCurrent),
            ),
            validator: AppValidation.notEmpty,
          ),
          const SizedBox(height: AppDesign.gapItemMd),
          BaseFormField(
            controller: _newPasswordController,
            label: l.profileNewPasswordLabel,
            prefixIcon: LucideIcons.lockKeyhole,
            obscureText: _obscureNew,
            textInputAction: TextInputAction.next,
            fillColor: colors.background,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureNew
                    ? LucideIcons.eye
                    : LucideIcons.eyeOff,
                size: AppDesign.iconSizeMd,
                color: colors.muted,
              ),
              onPressed: () => setState(() => _obscureNew = !_obscureNew),
            ),
            validator: (v) =>
                AppValidation.notEmpty(v) ??
                AppValidation.minLength(
                  v,
                  8,
                  message: l.authErrorWeakPassword,
                ) ??
                AppValidation.strongPassword(
                  v,
                  message: l.authErrorWeakPassword,
                ),
          ),
          const SizedBox(height: AppDesign.gapItemMd),
          BaseFormField(
            controller: _confirmPasswordController,
            label: l.profileConfirmPasswordLabel,
            prefixIcon: LucideIcons.lockKeyhole,
            obscureText: _obscureConfirm,
            textInputAction: TextInputAction.done,
            fillColor: colors.background,
            onFieldSubmitted: (_) => _submit(),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirm
                    ? LucideIcons.eye
                    : LucideIcons.eyeOff,
                size: AppDesign.iconSizeMd,
                color: colors.muted,
              ),
              onPressed: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
            ),
            validator: (v) =>
                AppValidation.notEmpty(v) ??
                AppValidation.match(
                  v,
                  _newPasswordController.text,
                  message: l.profilePasswordMismatch,
                ),
          ),
          const SizedBox(height: AppDesign.gapItemMd),
          BaseCheckbox(
            value: _logoutCurrentDevice,
            label: l.profileLogoutCurrentDevice,
            fullWidth: true,
            onChanged: (v) => setState(() => _logoutCurrentDevice = v),
          ),
          const SizedBox(height: AppDesign.gapSectionSm),
          BaseButton(
            label: l.profileChangePassword,
            type: BaseButtonType.filled,
            color: AppColors.secondary,
            fullWidth: true,
            isLoading: _isLoading,
            onPressed: _submit,
          ),
          const SizedBox(height: AppDesign.gapItemMd),
        ],
      ),
    );
  }
}

