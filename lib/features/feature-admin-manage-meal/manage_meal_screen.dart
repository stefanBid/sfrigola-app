import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/core/layouts/body/standard_page_layout.dart';

// Project Widgets
import 'package:sfrigola/features/feature-admin-manage-meal/widgets/manage_meal_form.dart';

class ManageMealScreen extends StatelessWidget {
  final String? mealId;
  const ManageMealScreen({super.key, this.mealId});

  @override
  Widget build(BuildContext context) {
    return StandardPageLayout(
      hasPadding: false,
      appBar: const ClassicAppBar(
        leading: Icon(PhosphorIconsBold.fileText),
        title: 'Manage Meal',
      ),
      body: ManageMealForm(mealId: mealId),
    );
  }
}
