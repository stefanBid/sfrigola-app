import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project l10n
import 'package:sfrigola/core/l10n/app_localizations.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Models
import 'package:sfrigola/core/models/category.dart';

// Project Providers
import 'package:sfrigola/features/feature-home/providers/categories_provider.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_box.dart';
import 'package:sfrigola/core/widgets/group-container/gc_list_view.dart';

class CategoriesGroupRow extends ConsumerWidget {
  final String? selectedCategoryId;
  final void Function(String)? onCategorySelected;

  const CategoriesGroupRow({
    super.key,
    this.selectedCategoryId,
    this.onCategorySelected,
  });

  Widget? _buildCategoryItem(
    BuildContext context,
    int index,
    List<Category> categories,
    String? selectedCategoryId,
  ) {
    if (index < 0 || index >= categories.length) return null;

    final category = categories[index];
    final isSelected = category.id == selectedCategoryId;

    return Padding(
      padding: AppDesign.paddingHorizontalLg.copyWith(
        left: index == 0 ? AppDesign.paddingHorizontalLg.left : 0,
        right: index == categories.length - 1
            ? AppDesign.paddingHorizontalLg.right
            : AppDesign.gapInlineSm,
      ),
      child: BaseBox(
        settings: BoxSettings(
          color: isSelected
              ? AppColors.primary.withAlpha(150)
              : AppColors.of(context).surface,
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

  Widget _buildSkeleton() => const _CategorySkeletonRow();

  Widget _buildError(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: AppDesign.paddingHorizontalLg,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.warningCircle,
              size: AppDesign.iconSizeSm,
              color: AppColors.of(context).muted,
            ),
            const SizedBox(width: AppDesign.gapInlineXs),
            Text(
              AppLocalizations.of(context)!.homeCategoriesLoadError,
              style: AppTypography.of(
                context,
              ).caption.copyWith(color: AppColors.of(context).muted),
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
          itemBuilder: (context, index) => _buildCategoryItem(
            context,
            index,
            value.categories,
            selectedCategoryId,
          ),
          itemCount: value.categories.length,
        ),
      ),
      AsyncError() => _buildError(context),
      AsyncLoading() => _buildSkeleton(),
    };
  }
}

// ─── Skeleton ────────────────────────────────────────────────────────────────

class _CategorySkeletonRow extends StatefulWidget {
  const _CategorySkeletonRow();

  @override
  State<_CategorySkeletonRow> createState() => _CategorySkeletonRowState();
}

class _CategorySkeletonRowState extends State<_CategorySkeletonRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  static const _chipWidths = [88.0, 72.0, 104.0, 80.0, 96.0];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _opacity = Tween<double>(
      begin: 0.35,
      end: 0.75,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: FadeTransition(
        opacity: _opacity,
        child: GcListView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _chipWidths.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? AppDesign.paddingHorizontalLg.left : 0,
              right: index == _chipWidths.length - 1
                  ? AppDesign.paddingHorizontalLg.right
                  : AppDesign.gapInlineSm,
            ),
            child: Container(
              width: _chipWidths[index],
              decoration: BoxDecoration(
                color: AppColors.of(context).muted,
                borderRadius: AppDesign.borderRadiusXs,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
