import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_router.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/core/layouts/body/standard_page_layout.dart';

// Project Providers
import 'package:sfrigola/features/feature-home/providers/selected_category_id_provider.dart';

// Project Widgets
import 'package:sfrigola/features/feature-home/widgets/categories_group_row.dart';
import 'package:sfrigola/features/feature-home/widgets/fake_search_box.dart';
import 'package:sfrigola/features/feature-home/widgets/sections_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPageLayout(
      hasPadding: false,
      appBar: ClassicAppBar(
        leading: const Icon(PhosphorIconsBold.chefHat),
        title: AppLocale.getLabels(context).homeTitle,
        bottomContent: FakeSearchBox(
          onTap: () => AppRouter.goDeep(context, AppRouter.search),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(
            builder: (context, ref, _) {
              final selectedId = ref.watch(selectedCategoryIdProvider);
              return CategoriesGroupRow(
                selectedCategoryId: selectedId,
                onCategorySelected: (id) =>
                    ref.read(selectedCategoryIdProvider.notifier).select(id),
              );
            },
          ),
          const SizedBox(height: AppDesign.gapSectionMd),
          const Expanded(child: SectionsContainer()),
        ],
      ),
    );
  }
}
