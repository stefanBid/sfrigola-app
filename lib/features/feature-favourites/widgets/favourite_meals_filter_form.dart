import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Providers
import 'package:sfrigola/features/feature-favourites/providers/favourites_filter_provider.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Models
import 'package:sfrigola/core/models/be-models/be_filters.dart';
import 'package:sfrigola/core/models/meal.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_button.dart';
import 'package:sfrigola/core/widgets/base_dropdown.dart';
import 'package:sfrigola/core/widgets/base_range.dart';

class FavouriteMealsFilterForm extends ConsumerStatefulWidget {
  const FavouriteMealsFilterForm({super.key, required this.onCloseForm});

  final VoidCallback onCloseForm;

  @override
  ConsumerState<FavouriteMealsFilterForm> createState() =>
      _FavouriteMealsFilterFormState();
}

class _FavouriteMealsFilterFormState
    extends ConsumerState<FavouriteMealsFilterForm> {
  static const double _rateMin = 0.0;
  static const double _rateMax = 5.0;

  final _formKey = GlobalKey<FormState>();

  Complexity? _complexity;
  Affordability? _affordability;
  SortOrder? _sortOrder;
  RangeValues _rateRange = const RangeValues(_rateMin, _rateMax);

  @override
  void initState() {
    super.initState();
    final current = ref.read(favouritesFilterProvider);
    _complexity = current.complexity;
    _affordability = current.affordability;
    _sortOrder = current.sortOrder;
    _rateRange = current.rateRange ?? const RangeValues(_rateMin, _rateMax);
  }

  void _apply() {
    if (!_formKey.currentState!.validate()) return;
    final isFullRange =
        _rateRange.start == _rateMin && _rateRange.end == _rateMax;
    ref
        .read(favouritesFilterProvider.notifier)
        .replaceWith(
          FavouritesFilterProviderState(
            complexity: _complexity,
            affordability: _affordability,
            rateRange: isFullRange ? null : _rateRange,
            sortOrder: _sortOrder,
          ),
        );
    widget.onCloseForm();
  }

  void _reset() {
    ref.read(favouritesFilterProvider.notifier).reset();
    widget.onCloseForm();
  }

  @override
  Widget build(BuildContext context) {
    final safeBottomSpace = MediaQuery.of(context).padding.bottom;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Complexity ──────────────────────────────────────────────────
          BaseDropdown<Complexity>(
            initialValue: _complexity,
            label: AppLocale.getLabels(context).favouritesFilterComplexityLabel,
            voidSelectionItemLabel: AppLocale.getLabels(
              context,
            ).favouritesFilterComplexityAll,
            prefixIcon: PhosphorIconsRegular.chartBar,
            items: Complexity.values
                .map(
                  (c) => BaseDropdownOption(value: c, label: c.label(context)),
                )
                .toList(),
            onChanged: (v) => setState(() => _complexity = v),
          ),
          const SizedBox(height: AppDesign.gapSectionSm),

          // ── Affordability ────────────────────────────────────────────────
          BaseDropdown<Affordability>(
            initialValue: _affordability,
            label: AppLocale.getLabels(
              context,
            ).favouritesFilterAffordabilityLabel,
            voidSelectionItemLabel: AppLocale.getLabels(
              context,
            ).favouritesFilterAffordabilityAll,
            prefixIcon: PhosphorIconsRegular.tag,
            items: Affordability.values
                .map(
                  (a) => BaseDropdownOption(value: a, label: a.label(context)),
                )
                .toList(),
            onChanged: (v) => setState(() => _affordability = v),
          ),
          const SizedBox(height: AppDesign.gapSectionSm),

          // ── Sort order ───────────────────────────────────────────────────
          BaseDropdown<SortOrder>(
            initialValue: _sortOrder,
            label: AppLocale.getLabels(context).favouritesFilterSortOrderLabel,
            voidSelectionItemLabel: AppLocale.getLabels(
              context,
            ).favouritesFilterSortOrderNone,
            prefixIcon: PhosphorIconsRegular.arrowsDownUp,
            items: SortOrder.values
                .map(
                  (s) => BaseDropdownOption(value: s, label: s.label(context)),
                )
                .toList(),
            onChanged: (v) => setState(() => _sortOrder = v),
          ),
          const SizedBox(height: AppDesign.gapSectionSm),

          // ── Rate range ───────────────────────────────────────────────────
          BaseRange(
            label: AppLocale.getLabels(context).favouritesFilterRateLabel,
            values: _rateRange,
            min: _rateMin,
            max: _rateMax,
            divisions: 10,
            valueFormatter: (v) => v.toStringAsFixed(1),
            onChanged: (v) => setState(() => _rateRange = v),
          ),
          const SizedBox(height: AppDesign.gapSectionLg),

          // ── Actions ──────────────────────────────────────────────────────
          BaseButton(
            label: AppLocale.getLabels(context).favouritesFilterApply,
            type: BaseButtonType.filled,
            fullWidth: true,
            onPressed: _apply,
          ),
          const SizedBox(height: AppDesign.gapSectionXs),
          BaseButton(
            label: AppLocale.getLabels(context).favouritesFilterReset,
            type: BaseButtonType.ghost,
            fullWidth: true,
            pill: true,
            onPressed: _reset,
          ),

          SizedBox(height: safeBottomSpace),
        ],
      ),
    );
  }
}
