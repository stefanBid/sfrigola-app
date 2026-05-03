import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// project Helpers
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/core/layouts/body/standard_page_layout.dart';
import 'package:sfrigola/core/widgets/base_icon_button.dart';

// Project Widgets
import 'package:sfrigola/features/feature-favourites/widgets/favourite_meals_grid_container.dart';
import 'package:sfrigola/features/feature-favourites/widgets/favourite_meals_filter_form.dart';
import 'package:sfrigola/core/widgets/base_bottom_sheet.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPageLayout(
      appBar: ClassicAppBar(
        leading: const Icon(PhosphorIconsBold.heart),
        title: AppLocale.getLabels(context).favouritesTitle,
        actions: [
          BaseIconButton(
            icon: PhosphorIconsBold.funnel,
            onPressed: () => BaseBottomSheet.show(
              context,
              child: FavouriteMealsFilterForm(
                onCloseForm: () => BaseBottomSheet.hide(context),
              ),
              heightFactor: 0.6,
            ),
          ),
        ],
      ),
      body: const FavouriteMealsGridContainer(),
    );
  }
}
