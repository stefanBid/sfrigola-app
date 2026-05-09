import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Providers
import 'package:sfrigola/core/providers/meals_filter_provider.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/body/standard_page_layout.dart';
import 'package:sfrigola/core/layouts/app_bars/classic_app_bar.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_icon_button.dart';
import 'package:sfrigola/core/widgets/base_bottom_sheet.dart';
import 'package:sfrigola/core/custom-widgets/meals-filter-form/meals_filter_form.dart';
import 'package:sfrigola/features/feature-admin-cookbook/widgets/cookbook_grid_container.dart';

class CookbookScreen extends StatelessWidget {
  const CookbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPageLayout(
      appBar: ClassicAppBar(
        leading: const Icon(PhosphorIconsBold.fileText),
        title: 'Manage App CookBook',
        actions: [
          Builder(
            builder: (context) => BaseIconButton(
              icon: PhosphorIconsRegular.plus,
              onPressed: null,
              tooltip: AppLocale.getLabels(context).tooltipAddMeal,
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final filter = ref.watch(
                mealsFilterProvider(MealsFilterScope.adminCookbook),
              );
              return BaseIconButton(
                icon: filter.hasFilters
                    ? PhosphorIconsFill.funnel
                    : PhosphorIconsRegular.funnel,
                badgeCount: filter.appliedFiltersCount,
                tooltip: AppLocale.getLabels(context).tooltipFilterMeals,
                onPressed: () => BaseBottomSheet.show(
                  context,
                  child: MealsFilterForm(
                    scope: MealsFilterScope.adminCookbook,
                    onCloseForm: () => BaseBottomSheet.hide(context),
                  ),
                  heightFactor: 0.6,
                ),
              );
            },
          ),
        ],
      ),
      body: const CookbookGridContainer(),
    );
  }
}
