import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import '../../helpers/app_colors.dart';
import '../../helpers/app_design.dart';
import '../../helpers/app_typography.dart';
import '../../helpers/app_validation.dart';

// Project Layouts
import '../../layouts/app_bars/classic_app_bar.dart';
import '../../layouts/body/standard_page_layout.dart';

// Project Widgets
import '../../widgets/base_button.dart';
import '../../widgets/base_form_field.dart';
import '../../widgets/base_scaffold_messenger.dart';

class FormSection extends StatefulWidget {
  const FormSection({super.key});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController surnameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  bool _isSubmitting = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _clearForm() {
    nameController.clear();
    surnameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    if (_showPassword) setState(() => _showPassword = false);
    if (_showConfirmPassword) setState(() => _showConfirmPassword = false);
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      BaseScaffoldMessenger.show(
        context,
        message: 'Form submitted successfully!',
        type: SnackBarType.success,
      );
      _clearForm();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // — Personal Information
            Text(
              'Personal Information',
              style: AppTypography.of(context).heading3,
            ),
            const SizedBox(height: AppDesign.gapItemSm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BaseFormField(
                    fillColor: AppColors.of(context).surface,
                    controller: nameController,
                    label: 'Name',
                    prefixIcon: PhosphorIconsRegular.user,
                    validator: (value) => AppValidation.notEmpty(
                      value,
                      message: 'Name is required',
                    ),
                  ),
                ),
                const SizedBox(width: AppDesign.gapInlineSm),
                Expanded(
                  child: BaseFormField(
                    controller: surnameController,
                    fillColor: AppColors.of(context).surface,
                    label: 'Surname',
                    prefixIcon: PhosphorIconsRegular.user,
                    validator: (value) => AppValidation.notEmpty(
                      value,
                      message: 'Surname is required',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDesign.gapSectionMd),

            // — Account Information
            Text(
              'Account Information',
              style: AppTypography.of(context).heading3,
            ),
            const SizedBox(height: AppDesign.gapItemSm),
            BaseFormField(
              controller: emailController,
              fillColor: AppColors.of(context).surface,
              label: 'Email',
              prefixIcon: PhosphorIconsRegular.envelope,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  AppValidation.notEmpty(value, message: 'Email is required') ??
                  AppValidation.email(value),
            ),
            const SizedBox(height: AppDesign.gapItemSm),
            BaseFormField(
              controller: passwordController,
              fillColor: AppColors.of(context).surface,
              label: 'Password',
              prefixIcon: PhosphorIconsRegular.lock,
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword
                      ? PhosphorIconsRegular.eye
                      : PhosphorIconsRegular.eyeSlash,
                  size: 20,
                ),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              ),
              obscureText: !_showPassword,
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  AppValidation.notEmpty(
                    value,
                    message: 'Password is required',
                  ) ??
                  AppValidation.minLength(
                    value,
                    6,
                    message: 'Minimum 6 characters',
                  ) ??
                  AppValidation.strongPassword(value),
            ),
            const SizedBox(height: AppDesign.gapItemSm),
            BaseFormField(
              controller: confirmPasswordController,
              fillColor: AppColors.of(context).surface,
              label: 'Confirm Password',
              prefixIcon: PhosphorIconsRegular.lockKey,
              suffixIcon: IconButton(
                icon: Icon(
                  _showConfirmPassword
                      ? PhosphorIconsRegular.eye
                      : PhosphorIconsRegular.eyeSlash,
                  size: 20,
                ),
                onPressed: () => setState(
                  () => _showConfirmPassword = !_showConfirmPassword,
                ),
              ),
              obscureText: !_showConfirmPassword,
              textInputAction: TextInputAction.done,
              validator: (value) => AppValidation.match(
                value,
                passwordController.text,
                message: 'Passwords do not match',
              ),
            ),
            const SizedBox(height: AppDesign.gapSectionLg),

            // — Submit
            BaseButton(
              fullWidth: true,
              onPressed: _isSubmitting ? null : _submit,
              label: 'Submit',
              icon: PhosphorIconsBold.paperPlaneRight,
              isLoading: _isSubmitting,
            ),
          ],
        ),
      ),
    );
  }
}

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StandardPageLayout(
      appBar: ClassicAppBar(
        leading: Icon(PhosphorIconsBold.fileText),
        title: 'Build Professional Forms',
      ),
      body: FormSection(),
    );
  }
}
