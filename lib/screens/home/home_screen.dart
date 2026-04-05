import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_locale.dart';
import 'package:sfrigola/helpers/app_logger.dart';
import 'package:sfrigola/helpers/app_router.dart';
import 'package:sfrigola/helpers/app_typography.dart';

// Project Layouts
import 'package:sfrigola/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/layouts/body/standard_page_layout.dart';

// Project Widgets
import 'package:sfrigola/screens/home/widgets/general_search_box.dart';
import 'package:sfrigola/screens/home/widgets/meals_group_row.dart';
import 'package:sfrigola/widgets/base_card.dart';
import 'package:sfrigola/widgets/group-container/gc_list_view.dart';

class TestItmes {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  TestItmes({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static List<TestItmes> _onGenerateDummyItems(int count, int idSeed) {
    return List.generate(
      count,
      (index) => TestItmes(
        id: '${index + idSeed}',
        title: 'Item ${index + idSeed}',
        description: 'Description for item ${index + idSeed}',
        imageUrl: 'https://picsum.photos/id/${index + idSeed}/200/300',
      ),
    );
  }

  static Widget? _buildDummyItem(
    BuildContext context,
    int index,
    List<TestItmes> dummyItems,
  ) {
    if (index >= dummyItems.length) return null;
    final item = dummyItems[index];
    final isFirstItem = index == 0;

    return BaseCard(
      key: ValueKey(item.id),
      title: item.title,
      content: item.description,
      imageUrl: item.imageUrl,
      padding: AppDesign.paddingHorizontalLg.copyWith(
        left: isFirstItem ? AppDesign.paddingHorizontalLg.left : 0,
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        AppRouter.goDeep(
          context,
          AppRouter.details,
          params: DetailParams(detailId: item.id),
        );
      },
    );
  }

  static void _onSearchChanged(String value) {
    AppLogger.debug('Search query: $value', tag: 'HomeScreen');
  }

  @override
  Widget build(BuildContext context) {
    final dummyItems1 = _onGenerateDummyItems(20, 1);
    final dummyItems2 = _onGenerateDummyItems(10, 21);
    final dummyItems3 = _onGenerateDummyItems(25, 31);

    return StandardPageLayout(
      hasPadding: false,
      appBar: ClassicAppBar(
        leading: const Icon(PhosphorIconsBold.house),
        title: AppLocale.getLabels(context).homeTitle,
        bottomContent: const GeneralSearchBox(onChanged: _onSearchChanged),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppDesign.paddingHorizontalLg,
            child: Text(
              AppLocale.getLabels(context).homeSubtitle,
              style: AppTypography.of(context).body,
            ),
          ),
          const SizedBox(height: AppDesign.gapSectionLg),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    vertical: AppDesign.gapSectionLg,
                  ),
                  child: MealsGroupRow(
                    title: AppLocale.getLabels(context).homeSectionRecent,
                    subtitle: AppLocale.getLabels(context).homeSectionRecentSubtitle,
                    icon: PhosphorIconsBold.star,
                    groupHeight: 220,
                    child: GcListView(
                      itemBuilder: (context, index) =>
                          _buildDummyItem(context, index, dummyItems1),
                      scrollDirection: Axis.horizontal,
                      itemCount: dummyItems1.length,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    vertical: AppDesign.gapSectionLg,
                  ),
                  child: MealsGroupRow(
                    title: AppLocale.getLabels(context).homeSectionFavorites,
                    subtitle: AppLocale.getLabels(context).homeSectionFavoritesSubtitle,
                    icon: PhosphorIconsBold.heart,
                    groupHeight: 220,
                    child: GcListView(
                      itemBuilder: (context, index) =>
                          _buildDummyItem(context, index, dummyItems2),
                      scrollDirection: Axis.horizontal,
                      itemCount: dummyItems2.length,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    vertical: AppDesign.gapSectionLg,
                  ),
                  child: MealsGroupRow(
                    title: AppLocale.getLabels(context).homeSectionPopular,
                    subtitle: AppLocale.getLabels(context).homeSectionPopularSubtitle,
                    icon: PhosphorIconsBold.fire,
                    groupHeight: 220,
                    child: GcListView(
                      itemBuilder: (context, index) =>
                          _buildDummyItem(context, index, dummyItems3),
                      scrollDirection: Axis.horizontal,
                      itemCount: dummyItems3.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
