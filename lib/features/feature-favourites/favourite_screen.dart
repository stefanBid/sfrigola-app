import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

// Project Providers
import 'package:sfrigola/core/providers/current_user_provider.dart';
import 'package:sfrigola/core/providers/meals_filter_provider.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/core/layouts/body/message_page_layout.dart';
import 'package:sfrigola/core/layouts/body/standard_page_layout.dart';

// Project Widgets
import 'package:sfrigola/core/custom-widgets/meals-filter-form/meals_filter_form.dart';
import 'package:sfrigola/core/widgets/base_bottom_sheet.dart';
import 'package:sfrigola/core/widgets/base_button.dart';
import 'package:sfrigola/core/widgets/base_icon_button.dart';
import 'package:sfrigola/features/feature-favourites/widgets/favourite_meals_grid_container.dart';

class FavouriteScreen extends ConsumerWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocale.getLabels(context);
    final userAsync = ref.watch(currentUserProvider);
    final filter = ref.watch(mealsFilterProvider(MealsFilterScope.favorites));

    return StandardPageLayout(
      appBar: ClassicAppBar(
        leading: const Icon(LucideIcons.heart),
        title: l.favouritesTitle,
        actions: userAsync.value != null
            ? [
                BaseIconButton(
                  icon: filter.hasFilters
                      ? LucideIcons.funnel
                      : LucideIcons.funnel,
                  badgeCount: filter.appliedFiltersCount,
                  tooltip: l.tooltipFilterMeals,
                  onPressed: () => BaseBottomSheet.show(
                    context,
                    child: MealsFilterForm(
                      scope: MealsFilterScope.favorites,
                      onCloseForm: () => BaseBottomSheet.hide(context),
                    ),
                    heightFactor: 0.6,
                  ),
                ),
              ]
            : null,
      ),
      body: switch (userAsync) {
        AsyncData(:final value) when value == null => MessagePageLayout(
          icon: LucideIcons.heart,
          message: l.favouritesLoginRequired,
          type: MessagePageType.muted,
          customButton: BaseButton(
            label: l.favouritesLoginButton,
            onPressed: () => context.push('/login'),
          ),
        ),
        AsyncData() => const FavouriteMealsGridContainer(),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
