import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_typography.dart';

class NoDataView extends StatelessWidget {
  final String message;

  const NoDataView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppDesign.paddingPage,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsBold.forkKnife,
              size: 48,
              color: AppColors.of(context).muted,
            ),
            const SizedBox(height: AppDesign.gapSectionSm),
            Text(
              message,
              style: AppTypography.of(context).body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
