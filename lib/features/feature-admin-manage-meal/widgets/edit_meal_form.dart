import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_router.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_button.dart';
import 'package:sfrigola/core/widgets/base_dropdown.dart';
import 'package:sfrigola/core/widgets/base_form_field.dart';

class EditMealForm extends ConsumerStatefulWidget {
  const EditMealForm({super.key, required this.mealId});

  final String mealId;

  @override
  ConsumerState<EditMealForm> createState() => _EditMealFormState();
}

class _EditMealFormState extends ConsumerState<EditMealForm> {
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process form submission logic here
    }
  }

  void _cancelForm() {
    FocusScope.of(context).unfocus();
    AppRouter.goBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                'Form Fields Here',
                style: AppTypography.of(context).heading2,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: BaseButton(
                  label: 'Update',
                  icon: PhosphorIconsRegular.check,
                  onPressed: _submitForm,
                ),
              ),
              const SizedBox(width: AppDesign.gapInlineMd),
              Expanded(
                child: BaseButton(
                  label: 'Cancel',
                  icon: PhosphorIconsRegular.x,
                  type: BaseButtonType.outlined,
                  onPressed: _cancelForm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
