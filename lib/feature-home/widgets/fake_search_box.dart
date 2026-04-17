import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_input.dart';

class FakeSearchBox extends StatelessWidget {
  final VoidCallback onTap;

  const FakeSearchBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      readOnly: true,
      onTap: onTap,
      hint: AppLocale.getLabels(context).homeSearchHint,
      prefixIcon: Icon(
        PhosphorIconsRegular.magnifyingGlass,
        size: 20,
        color: AppColors.of(context).muted,
      ),
    );
  }
}
