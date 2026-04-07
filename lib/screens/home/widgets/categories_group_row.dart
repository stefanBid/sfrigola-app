import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_typography.dart';

// Project Models
import 'package:sfrigola/models/category.dart';

// Project Providers
import 'package:sfrigola/providers/meal_provider.dart';

// Project Widgets
import 'package:sfrigola/widgets/base_box.dart';
import 'package:sfrigola/widgets/group-container/gc_list_view.dart';

class CategoriesGroupRow extends ConsumerWidget {
  final String selectedCategoryId;
  final void Function(String)? onCategorySelected;

  const CategoriesGroupRow({
    super.key,
    required this.selectedCategoryId,
    this.onCategorySelected,
  });

  Widget? _buildCategoryItem(
    BuildContext context,
    int index,
    List<Category> categories,
    String selectedCategoryId,
  ) {
    if (index < 0 || index >= categories.length) return null;

    final category = categories[index];
    final isSelected = category.id == selectedCategoryId;
    final accent = AppColors.of(context).isDark
        ? AppColors.secondary
        : AppColors.primary;

    return Padding(
      padding: AppDesign.paddingHorizontalLg.copyWith(
        left: index == 0 ? AppDesign.paddingHorizontalLg.left : 0,
        right: index == categories.length - 1
            ? AppDesign.paddingHorizontalLg.right
            : AppDesign.gapInlineSm,
      ),
      child: BaseBox(
        settings: BoxSettings(
          color: isSelected ? accent : AppColors.of(context).surface,
        ),
        onTap: () => onCategorySelected?.call(category.id),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (category.icon != null) ...[
              Text(category.icon!, style: AppTypography.of(context).bodyMedium),
              const SizedBox(width: AppDesign.gapInlineXs),
            ],
            Text(
              category.title,
              style: AppTypography.of(context).small.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.of(context).text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return switch (categoriesAsync) {
      AsyncData(:final value) => SizedBox(
          height: 40,
          child: GcListView(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                _buildCategoryItem(context, index, value, selectedCategoryId),
            itemCount: value.length,
          ),
        ),
      AsyncError() => const SizedBox.shrink(),
      AsyncLoading() => const SizedBox(
          height: 40,
          child: Center(child: LinearProgressIndicator()),
        ),
    };
  }
}
