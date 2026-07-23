import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_router.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/core/layouts/body/standard_page_layout.dart';

// Project Providers
import 'package:sfrigola/features/feature-admin-cookbook/providers/all_meals_by_filter_provider.dart';
import 'package:sfrigola/features/feature-admin-manage-meal/providers/delete_meal_provider.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_icon_button.dart';
import 'package:sfrigola/core/widgets/base_scaffold_messenger.dart';
import 'package:sfrigola/features/feature-admin-manage-meal/widgets/manage_meal_form.dart';

class ManageMealScreen extends ConsumerWidget {
  final String? mealId;
  const ManageMealScreen({super.key, this.mealId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocale.getLabels(context);
    final isEdit = mealId != null;

    ref.listen(deleteMealProvider, (previous, next) {
      if (!context.mounted) return;
      if (next is AsyncError) {
        BaseScaffoldMessenger.show(
          context,
          message: AppLocale.errorFor(context, next.error),
          type: SnackBarType.error,
        );
      } else if (next is AsyncData && previous?.isLoading == true) {
        ref.invalidate(allMealsByFilterProvider);
        BaseScaffoldMessenger.show(
          context,
          message: l.manageMealFormDeleteSuccessMessage,
          type: SnackBarType.success,
        );
        AppRouter.goBack(context);
      }
    });

    return StandardPageLayout(
      hasPadding: false,
      appBar: ClassicAppBar(
        title: isEdit ? l.manageMealFormTitleEdit : l.manageMealFormTitleAdd,
        actions: [
          BaseIconButton(
            icon: LucideIcons.arrowLeft,
            tooltip: l.manageMealFormTooltipBack,
            onPressed: () => AppRouter.goBack(context),
          ),
          if (isEdit)
            BaseIconButton(
              icon: LucideIcons.trash2,
              tooltip: l.manageMealFormTooltipDelete,
              onPressed: () =>
                  ref.read(deleteMealProvider.notifier).submit(mealId!),
            ),
        ],
      ),
      body: ManageMealForm(mealId: mealId),
    );
  }
}

