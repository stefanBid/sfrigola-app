import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_typography.dart';

// Project Models
import 'package:sfrigola/models/category.dart';

// Project Widgets
import 'package:sfrigola/widgets/base_box.dart';
import 'package:sfrigola/widgets/group-container/gc_list_view.dart';

class CategoriesGroupRow extends StatelessWidget {
  final List<Category> categories;
  final String selectedCategoryId;
  final void Function(String)? onCategorySelected;

  const CategoriesGroupRow({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    this.onCategorySelected,
  });

  Widget? _buildCategoryItem(
    BuildContext context,
    int index,
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: GcListView(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            _buildCategoryItem(context, index, selectedCategoryId),
        itemCount: categories.length,
      ),
    );
  }
}
