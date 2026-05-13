import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Projects Providers
import 'package:sfrigola/core/providers/categories_provider.dart';
import 'package:sfrigola/core/providers/meal_by_id_provider.dart';
import 'package:sfrigola/features/feature-admin-manage-meal/providers/add_meal_provider.dart';
import 'package:sfrigola/features/feature-admin-manage-meal/providers/edit_meal_provider.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/category.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_router.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/body/message_page_layout.dart';

// Project Widgets
import 'package:sfrigola/features/feature-admin-manage-meal/widgets/form-components/dietary_info.dart';
import 'package:sfrigola/features/feature-admin-manage-meal/widgets/form-components/form_action_bar.dart';
import 'package:sfrigola/features/feature-admin-manage-meal/widgets/skeletons/manage_meal_form_skeleton.dart';
import 'package:sfrigola/core/widgets/base_dropdown.dart';
import 'package:sfrigola/core/widgets/base_form_field.dart';
import 'package:sfrigola/core/widgets/base_slider.dart';
import 'package:sfrigola/core/widgets/base_scaffold_messenger.dart';
import 'package:sfrigola/core/widgets/group-container/gc_section_view.dart';

class ManageMealForm extends ConsumerStatefulWidget {
  const ManageMealForm({super.key, this.mealId});

  final String? mealId;

  @override
  ConsumerState<ManageMealForm> createState() => _ManageMealFormState();
}

class _ManageMealFormState extends ConsumerState<ManageMealForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Category? _category;
  Complexity? _complexity;
  Affordability? _affordability;
  double _durationMinutes = 30;
  DietaryInfoFields _dietaryInfoFields = const DietaryInfoFields();
  bool _populated = false;

  @override
  void initState() {
    super.initState();
    if (widget.mealId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _populated) return;
        final mealAsync = ref.read(mealByIdProvider(widget.mealId!));
        final cats = ref.read(categoriesProvider).value?.categories ?? [];
        mealAsync.whenData((meal) => _populateFromMeal(meal, cats));
      });
    }
  }

  void _populateFromMeal(Meal meal, List<Category> availableCategories) {
    if (_populated) return;
    titleController.text = meal.title;
    subtitleController.text = meal.subtitle;
    descriptionController.text = meal.description;
    final matching = availableCategories.where(
      (c) => meal.categories.contains(c.id),
    );
    setState(() {
      _category = matching.isEmpty ? null : matching.first;
      _complexity = meal.complexity;
      _affordability = meal.affordability;
      _durationMinutes = meal.duration.toDouble();
      _dietaryInfoFields = DietaryInfoFields(
        isGlutenFree: meal.isGlutenFree,
        isLactoseFree: meal.isLactoseFree,
        isVegan: meal.isVegan,
        isVegetarian: meal.isVegetarian,
      );
      _populated = true;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final mealObj = Meal(
        id: widget.mealId ?? const Uuid().v4(),
        title: titleController.text,
        subtitle: subtitleController.text,
        description: descriptionController.text,
        categories: _category == null ? [] : [_category!.id],
        complexity: _complexity!,
        affordability: _affordability!,
        duration: _durationMinutes.toInt(),
        isGlutenFree: _dietaryInfoFields.isGlutenFree,
        isLactoseFree: _dietaryInfoFields.isLactoseFree,
        isVegan: _dietaryInfoFields.isVegan,
        isVegetarian: _dietaryInfoFields.isVegetarian,
        rate: 0,
        steps: [],
        ingredients: [],
        imageUrl: '',
        servings: 1,
      );
      if (widget.mealId == null) {
        ref.read(addMealProvider.notifier).submit(mealObj);
      } else {
        ref.read(editMealProvider.notifier).submit(mealObj);
      }
    }
  }

  void _closeForm() {
    FocusScope.of(context).unfocus();
    AppRouter.goBack(context);
  }

  @override
  Widget build(BuildContext context) {
    // Operation providers
    final addMealOp = ref.watch(addMealProvider);
    final editMealOp = ref.watch(editMealProvider);

    final categories = ref.watch(categoriesProvider);
    final l = AppLocale.getLabels(context);

    // Manage only error state
    ref.listen(addMealProvider, (previous, next) {
      if (!mounted) return;
      if (next is AsyncError) {
        BaseScaffoldMessenger.show(
          context,
          duration: const Duration(seconds: 1),
          message: AppLocale.errorFor(context, next.error),
          type: SnackBarType.error,
        );
      } else if (next is AsyncData && previous?.isLoading == true) {
        BaseScaffoldMessenger.show(
          context,
          duration: const Duration(seconds: 1),
          message: l.manageMealFormAddSuccessMessage,
          type: SnackBarType.success,
        );
        _closeForm();
      }
    });

    ref.listen(editMealProvider, (previous, next) {
      if (!mounted) return;
      if (next is AsyncError) {
        BaseScaffoldMessenger.show(
          context,
          duration: const Duration(seconds: 1),
          message: AppLocale.errorFor(context, next.error),
          type: SnackBarType.error,
        );
      } else if (next is AsyncData && previous?.isLoading == true) {
        BaseScaffoldMessenger.show(
          context,
          duration: const Duration(seconds: 1),
          message: l.manageMealFormEditSuccessMessage,
          type: SnackBarType.success,
        );
        _closeForm();
      }
    });

    if (widget.mealId != null) {
      final mealAsync = ref.watch(mealByIdProvider(widget.mealId!));

      ref.listen<AsyncValue<Meal>>(mealByIdProvider(widget.mealId!), (_, next) {
        if (_populated) return;
        next.whenData((meal) {
          final cats = ref.read(categoriesProvider).value?.categories ?? [];
          _populateFromMeal(meal, cats);
        });
      });

      if (!_populated) {
        if (mealAsync.isLoading) {
          return const ManageMealFormSkeleton();
        }
        if (mealAsync.hasError) {
          return MessagePageLayout(
            icon: PhosphorIconsRegular.warningCircle,
            message: AppLocale.errorFor(context, mealAsync.error!),
            onRetry: () => ref.invalidate(mealByIdProvider(widget.mealId!)),
          );
        }
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: AppDesign.paddingLg,
                child: Column(
                  children: [
                    GcSectionView(
                      title: l.manageMealFormSectionGeneralInfo,
                      icon: PhosphorIconsRegular.notepad,
                      child: Column(
                        children: [
                          BaseFormField(
                            controller: titleController,
                            fillColor: AppColors.of(context).surface,
                            label: l.manageMealFormFieldTitleLabel,
                            hint: l.manageMealFormFieldTitleHint,
                            prefixIcon: PhosphorIconsRegular.fileText,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: AppDesign.gapSectionMd),
                          BaseFormField(
                            controller: subtitleController,
                            fillColor: AppColors.of(context).surface,
                            label: l.manageMealFormFieldSubtitleLabel,
                            hint: l.manageMealFormFieldSubtitleHint,
                            prefixIcon: PhosphorIconsRegular.fileText,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: AppDesign.gapSectionMd),
                          BaseFormField(
                            controller: descriptionController,
                            fillColor: AppColors.of(context).surface,
                            label: l.manageMealFormFieldDescriptionLabel,
                            hint: l.manageMealFormFieldDescriptionHint,
                            prefixIcon: PhosphorIconsRegular.fileText,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: null,
                            maxLength: 500,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDesign.gapSectionLg),
                    GcSectionView(
                      title: l.manageMealFormSectionRecipeDetails,
                      icon: PhosphorIconsRegular.cookingPot,
                      child: Column(
                        children: [
                          BaseDropdown<Category>(
                            initialValue: _category,
                            label: l.manageMealFormFieldCategoryLabel,
                            hint: l.manageMealFormFieldCategoryHint,
                            prefixIcon: PhosphorIconsRegular.tag,
                            fillColor: AppColors.of(context).surface,
                            disabled:
                                categories.isLoading || categories.hasError,
                            isLoading: categories.isLoading,
                            items: switch (categories) {
                              AsyncData(:final value) =>
                                value.categories
                                    .map(
                                      (c) => BaseDropdownOption(
                                        value: c,
                                        label: c.title,
                                      ),
                                    )
                                    .toList(),
                              AsyncLoading() => [],
                              AsyncError() => [],
                            },
                            onChanged: (v) => setState(() => _category = v),
                          ),
                          const SizedBox(height: AppDesign.gapSectionMd),
                          BaseDropdown<Complexity>(
                            initialValue: _complexity,
                            label: l.favouritesFilterComplexityLabel,
                            hint: l.manageMealFormFieldComplexityHint,
                            prefixIcon: PhosphorIconsRegular.chartBar,
                            fillColor: AppColors.of(context).surface,
                            items: Complexity.values
                                .map(
                                  (c) => BaseDropdownOption(
                                    value: c,
                                    label: c.label(context),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) => setState(() => _complexity = v),
                          ),
                          const SizedBox(height: AppDesign.gapSectionMd),
                          BaseDropdown<Affordability>(
                            initialValue: _affordability,
                            label: l.favouritesFilterAffordabilityLabel,
                            hint: l.manageMealFormFieldAffordabilityHint,
                            prefixIcon: PhosphorIconsRegular.tag,
                            fillColor: AppColors.of(context).surface,
                            items: Affordability.values
                                .map(
                                  (a) => BaseDropdownOption(
                                    value: a,
                                    label: a.label(context),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _affordability = v),
                          ),
                          const SizedBox(height: AppDesign.gapSectionMd),
                          BaseSlider(
                            label: l.manageMealFormFieldDurationLabel,
                            value: _durationMinutes,
                            min: 5,
                            max: 300,
                            divisions: 59,
                            valueFormatter: (v) => '${v.toInt()} min',
                            onChanged: (v) =>
                                setState(() => _durationMinutes = v),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDesign.gapSectionLg),
                    GcSectionView(
                      title: l.manageMealFormSectionDietaryInfo,
                      subtitle: l.manageMealFormSectionDietaryInfoSubtitle,
                      icon: PhosphorIconsRegular.leaf,
                      child: DietaryInfo(
                        fields: _dietaryInfoFields,
                        onFieldsChanged: (v) =>
                            setState(() => _dietaryInfoFields = v),
                      ),
                    ),
                    const SizedBox(height: AppDesign.gapSectionSm),
                  ],
                ),
              ),
            ),
          ),
          FormActionBar(
            onCancel: _closeForm,
            onSubmit: _submitForm,
            isSubmitting: addMealOp.isLoading || editMealOp.isLoading,
          ),
        ],
      ),
    );
  }
}
