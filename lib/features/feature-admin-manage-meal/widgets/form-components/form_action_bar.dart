import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_button.dart';

class FormActionBar extends StatelessWidget {
  const FormActionBar({
    super.key,
    required this.onSubmit,
    this.isSubmitting = false,
  });

  final VoidCallback onSubmit;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    final l = AppLocale.getLabels(context);
    final bottomSpacing = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: AppDesign.paddingLg.copyWith(
        bottom: bottomSpacing + AppDesign.gapSectionMd,
      ),
      color: AppColors.of(context).bottomBar,
      child: BaseButton(
        label: l.manageMealFormSave,
        icon: PhosphorIconsRegular.check,
        fullWidth: true,
        isLoading: isSubmitting,
        onPressed: onSubmit,
      ),
    );
  }
}
