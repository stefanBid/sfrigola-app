import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Providers
import 'package:sfrigola/features/feature-favourites/providers/all_favourites_provider.dart';
import 'package:sfrigola/features/feature-meal-details/providers/update_favourite_provider.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_icon_button.dart';
import 'package:sfrigola/core/widgets/base_scaffold_messenger.dart';

class MealDetailsFavouriteButton extends ConsumerWidget {
  final String mealId;

  const MealDetailsFavouriteButton({super.key, required this.mealId});

  Future<void> _toggleFavourite(BuildContext context, WidgetRef ref) async {
    final isFav = ref.read(updateFavouriteProvider(mealId)).requireValue;
    try {
      await ref.read(updateFavouriteProvider(mealId).notifier).toggle();
      if (!context.mounted) return;
      ref.invalidate(allFavouritesProvider);
      BaseScaffoldMessenger.show(
        context,
        duration: const Duration(seconds: 1),
        message: isFav
            ? AppLocale.getLabels(context).favouriteRemoved
            : AppLocale.getLabels(context).favouriteAdded,
        type: SnackBarType.info,
      );
    } catch (e) {
      if (!context.mounted) return;
      BaseScaffoldMessenger.show(
        context,
        duration: const Duration(seconds: 1),
        message: AppLocale.errorFor(context, e),
        type: SnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavAsync = ref.watch(updateFavouriteProvider(mealId));
    final isFav = isFavAsync.value ?? false;

    return BaseIconButton(
      icon: isFav ? PhosphorIconsFill.heart : PhosphorIconsRegular.heart,
      color: Colors.white,
      iconColor: AppColors.error,
      type: IconButtonType.filled,
      onPressed: isFavAsync.isLoading
          ? null
          : () => _toggleFavourite(context, ref),
    );
  }
}
