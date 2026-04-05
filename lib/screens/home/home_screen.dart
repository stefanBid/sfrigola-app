import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import '../../helpers/app_colors.dart';
import '../../helpers/app_design.dart';
import '../../helpers/app_router.dart';
import '../../helpers/app_typography.dart';

// Project Layouts
import '../../layouts/app_bars/classic_app_bar.dart';
import '../../layouts/body/standard_page_layout.dart';

// Project Widgets
import '../../widgets/group-container/gc_list_view.dart';
import '../../widgets/base_card.dart';

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

class SectionGroup extends StatelessWidget {
  static const double _titleSectionHeight =
      22 + AppDesign.gapSectionXs; // heading3 + gap

  final String groupTitle;
  final IconData? groupIcon;
  final double groupHeight;
  final Widget child;

  const SectionGroup({
    super.key,
    required this.groupTitle,
    required this.child,
    this.groupIcon,
    required this.groupHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: groupHeight + _titleSectionHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: AppDesign.paddingHorizontalLg,
            child: Row(
              children: [
                if (groupIcon != null) ...[
                  Icon(groupIcon, size: 24, color: AppColors.primary),
                  const SizedBox(width: AppDesign.gapInlineXs),
                ],
                Text(groupTitle, style: AppTypography.of(context).heading3),
              ],
            ),
          ),
          const SizedBox(height: AppDesign.gapSectionXs),
          Expanded(child: child),
        ],
      ),
    );
  }
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
      onTap: () => AppRouter.goDeep(
        context,
        AppRouter.details,
        params: DetailParams(detailId: item.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dummyItems1 = _onGenerateDummyItems(20, 1);
    final dummyItems2 = _onGenerateDummyItems(10, 21);
    final dummyItems3 = _onGenerateDummyItems(25, 31);

    return StandardPageLayout(
      hasPadding: false,
      appBar: const ClassicAppBar(
        leading: Icon(PhosphorIconsBold.house),
        title: 'This is a modern Home Page',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppDesign.paddingHorizontalLg,
            child: Text(
              'You can customize this page as you like, it\'s just a template',
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
                  child: SectionGroup(
                    groupTitle: 'Section 1',
                    groupIcon: PhosphorIconsBold.star,
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
                  child: SectionGroup(
                    groupTitle: 'Section 2',
                    groupIcon: PhosphorIconsBold.heart,
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
                  child: SectionGroup(
                    groupTitle: 'Section 3',
                    groupIcon: PhosphorIconsBold.fire,
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
