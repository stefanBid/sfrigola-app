import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Providers
import 'package:sfrigola/features/feature-favourites/providers/favourites_filter_provider.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';

// Project Models
import 'package:sfrigola/core/models/be-models/be_filters.dart';
import 'package:sfrigola/core/models/meal.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_button.dart';
import 'package:sfrigola/core/widgets/base_dropdown.dart';
import 'package:sfrigola/core/widgets/base_form_field.dart';

class FavouriteMealsFilterForm extends ConsumerStatefulWidget {
  const FavouriteMealsFilterForm({super.key, required this.onCloseForm});

  final VoidCallback onCloseForm;

  @override
  ConsumerState<FavouriteMealsFilterForm> createState() =>
      _FavouriteMealsFilterFormState();
}

class _FavouriteMealsFilterFormState
    extends ConsumerState<FavouriteMealsFilterForm> {
  final _formKey = GlobalKey<FormState>();
  final _minRateController = TextEditingController();

  Complexity? _complexity;
  Affordability? _affordability;
  SortOrder? _sortOrder;

  @override
  void initState() {
    super.initState();
    final current = ref.read(favouritesFilterProvider);
    _complexity = current.complexity;
    _affordability = current.affordability;
    _sortOrder = current.sortOrder;
    _minRateController.text = current.minRate != null
        ? current.minRate.toString()
        : '';
  }

  @override
  void dispose() {
    _minRateController.dispose();
    super.dispose();
  }

  void _apply() {
    if (!_formKey.currentState!.validate()) return;
    final minRate = _minRateController.text.isNotEmpty
        ? double.tryParse(_minRateController.text)
        : null;
    ref
        .read(favouritesFilterProvider.notifier)
        .replaceWith(
          FavouritesFilterProviderState(
            complexity: _complexity,
            affordability: _affordability,
            minRate: minRate,
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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Complexity ──────────────────────────────────────────────────
          BaseDropdown<Complexity>(
            initialValue: _complexity,
            label: 'Complessità',
            voidSelectionItemLabel: 'Tutte',
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
            label: 'Prezzo',
            voidSelectionItemLabel: 'Tutti',
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
            label: 'Ordina per',
            voidSelectionItemLabel: 'Nessun ordine',
            items: const [
              BaseDropdownOption(
                value: SortOrder.alphabeticalAscending,
                label: 'A → Z',
              ),
              BaseDropdownOption(
                value: SortOrder.alphabeticalDescending,
                label: 'Z → A',
              ),
              BaseDropdownOption(
                value: SortOrder.rateAscending,
                label: 'Valutazione crescente',
              ),
              BaseDropdownOption(
                value: SortOrder.rateDescending,
                label: 'Valutazione decrescente',
              ),
              BaseDropdownOption(
                value: SortOrder.complexityAscending,
                label: 'Complessità crescente',
              ),
              BaseDropdownOption(
                value: SortOrder.complexityDescending,
                label: 'Complessità decrescente',
              ),
              BaseDropdownOption(
                value: SortOrder.affordabilityAscending,
                label: 'Prezzo crescente',
              ),
              BaseDropdownOption(
                value: SortOrder.affordabilityDescending,
                label: 'Prezzo decrescente',
              ),
            ],
            onChanged: (v) => setState(() => _sortOrder = v),
          ),
          const SizedBox(height: AppDesign.gapSectionSm),

          // ── Min rate ─────────────────────────────────────────────────────
          BaseFormField(
            controller: _minRateController,
            label: 'Valutazione minima',
            hint: 'Es. 3.5',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: AppDesign.gapSectionLg),
          BaseFormField(
            controller: _minRateController,
            label: 'Valutazione minima',
            hint: 'Es. 3.5',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: AppDesign.gapSectionLg),
          BaseFormField(
            controller: _minRateController,
            label: 'Valutazione minima',
            hint: 'Es. 3.5',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: AppDesign.gapSectionLg),

          // ── Actions ──────────────────────────────────────────────────────
          BaseButton(
            label: 'Applica filtri',
            type: BaseButtonType.filled,
            fullWidth: true,
            onPressed: _apply,
          ),
          const SizedBox(height: AppDesign.gapSectionXs),
          BaseButton(
            label: 'Reimposta',
            type: BaseButtonType.ghost,
            fullWidth: true,
            pill: true,
            onPressed: _reset,
          ),
        ],
      ),
    );
  }
}
