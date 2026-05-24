import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Projects Providers
import 'package:sfrigola/core/providers/categories_provider.dart';
import 'package:sfrigola/core/providers/meal_by_id_provider.dart';
import 'package:sfrigola/features/feature-admin-cookbook/providers/all_meals_by_filter_provider.dart';
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
import 'package:sfrigola/core/helpers/app_validation.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/body/message_page_layout.dart';

// Project Widgets
import 'package:sfrigola/features/feature-admin-manage-meal/widgets/form-components/dietary_info.dart';
import 'package:sfrigola/features/feature-admin-manage-meal/widgets/form-components/editable_list_field.dart';
import 'package:sfrigola/features/feature-admin-manage-meal/widgets/form-components/form_action_bar.dart';
import 'package:sfrigola/features/feature-admin-manage-meal/widgets/skeletons/manage_meal_form_skeleton.dart';
import 'package:sfrigola/core/widgets/base_dropdown.dart';
import 'package:sfrigola/core/widgets/base_form_field.dart';
import 'package:sfrigola/core/widgets/base_multi_select.dart';
import 'package:sfrigola/core/widgets/base_slider.dart';
import 'package:sfrigola/core/widgets/base_image_picker.dart';
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
  List<Category> _categories = [];
  Complexity? _complexity;
  Affordability? _affordability;
  double _durationMinutes = 30;
  DietaryInfoFields _dietaryInfoFields = const DietaryInfoFields();
  XFile? _pickedImage;
  String? _existingImageUrl;
  int _servings = 2;
  List<String> _ingredients = [];
  List<String> _steps = [];
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
    final matching = availableCategories
        .where((c) => meal.categories.contains(c.id))
        .toList();
    setState(() {
      _categories = matching;
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
      _existingImageUrl = meal.imageUrl.isNotEmpty ? meal.imageUrl : null;
      _servings = meal.servings;
      _ingredients = List<String>.from(meal.ingredients);
      _steps = List<String>.from(meal.steps);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final mealObj = Meal(
        id: widget.mealId ?? const Uuid().v4(),
        title: titleController.text,
        subtitle: subtitleController.text,
        description: descriptionController.text,
        categories: _categories.map((c) => c.id).toList(),
        complexity: _complexity!,
        affordability: _affordability!,
        duration: _durationMinutes.toInt(),
        isGlutenFree: _dietaryInfoFields.isGlutenFree,
        isLactoseFree: _dietaryInfoFields.isLactoseFree,
        isVegan: _dietaryInfoFields.isVegan,
        isVegetarian: _dietaryInfoFields.isVegetarian,
        rate: 0,
        steps: _steps,
        ingredients: _ingredients,
        imageUrl: _pickedImage?.path ?? _existingImageUrl ?? '',
        servings: _servings,
      );
      if (widget.mealId == null) {
        ref.read(addMealProvider.notifier).submit(mealObj);
      } else {
        ref.read(editMealProvider.notifier).submit(mealObj);
      }
    }
  }

  void _onImageSelected(XFile? file) {
    setState(() {
      _pickedImage = file;
      if (file == null) _existingImageUrl = null;
    });
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
        ref.invalidate(allMealsByFilterProvider);
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
        ref.invalidate(mealByIdProvider(widget.mealId!));
        ref.invalidate(allMealsByFilterProvider);
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
                          BaseImagePicker(
                            imageUrl: _pickedImage?.path ?? _existingImageUrl,
                            onImageSelected: _onImageSelected,
                          ),
                          const SizedBox(height: AppDesign.gapSectionMd),
                          BaseFormField(
                            controller: titleController,
                            fillColor: AppColors.of(context).surface,
                            label: l.manageMealFormFieldTitleLabel,
                            hint: l.manageMealFormFieldTitleHint,
                            prefixIcon: PhosphorIconsRegular.fileText,
                            textInputAction: TextInputAction.next,
                            validator: (value) => AppValidation.notEmpty(
                              value,
                              message: l.manageMealFormFieldTitleRequired,
                            ),
                          ),
                          const SizedBox(height: AppDesign.gapSectionMd),
                          BaseFormField(
                            controller: subtitleController,
                            fillColor: AppColors.of(context).surface,
                            label: l.manageMealFormFieldSubtitleLabel,
                            hint: l.manageMealFormFieldSubtitleHint,
                            prefixIcon: PhosphorIconsRegular.fileText,
                            textInputAction: TextInputAction.next,
                            validator: (value) => AppValidation.notEmpty(
                              value,
                              message: l.manageMealFormFieldSubtitleRequired,
                            ),
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
                            validator: (value) => AppValidation.notEmpty(
                              value,
                              message: l.manageMealFormFieldDescriptionRequired,
                            ),
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
                          BaseMultiSelect<Category>(
                            initialValues: _categories,
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
                            onChanged: (v) => setState(() => _categories = v),
                            validator: (value) => AppValidation.listNotEmpty(
                              value,
                              message: l.manageMealFormFieldCategoryRequired,
                            ),
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
                            validator: (value) => AppValidation.notEmpty(
                              value,
                              message: l.manageMealFormFieldComplexityRequired,
                            ),
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
                            validator: (value) => AppValidation.notEmpty(
                              value,
                              message:
                                  l.manageMealFormFieldAffordabilityRequired,
                            ),
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
                          const SizedBox(height: AppDesign.gapSectionMd),
                          BaseSlider(
                            label: l.manageMealFormFieldServingsLabel,
                            value: _servings.toDouble(),
                            min: 1,
                            max: 20,
                            divisions: 19,
                            valueFormatter: (v) => v.toInt().toString(),
                            onChanged: (v) =>
                                setState(() => _servings = v.toInt()),
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
                    const SizedBox(height: AppDesign.gapSectionLg),
                    GcSectionView(
                      title: l.manageMealFormSectionIngredients,
                      icon: PhosphorIconsRegular.listBullets,
                      child: EditableListField(
                        items: _ingredients,
                        onChanged: (v) => setState(() => _ingredients = v),
                        hint: l.manageMealFormFieldIngredientsHint,
                        multiline: true,
                        validator: (v) => (v == null || v.isEmpty)
                            ? l.manageMealFormFieldIngredientsEmpty
                            : null,
                      ),
                    ),
                    const SizedBox(height: AppDesign.gapSectionLg),
                    GcSectionView(
                      title: l.manageMealFormSectionSteps,
                      icon: PhosphorIconsRegular.listNumbers,
                      child: EditableListField(
                        items: _steps,
                        onChanged: (v) => setState(() => _steps = v),
                        hint: l.manageMealFormFieldStepsHint,
                        numbered: true,
                        multiline: true,
                        validator: (v) => (v == null || v.isEmpty)
                            ? l.manageMealFormFieldStepsEmpty
                            : null,
                      ),
                    ),
                    const SizedBox(height: AppDesign.gapSectionSm),
                  ],
                ),
              ),
            ),
          ),
          FormActionBar(
            onSubmit: _submitForm,
            isSubmitting: addMealOp.isLoading || editMealOp.isLoading,
          ),
        ],
      ),
    );
  }
}
