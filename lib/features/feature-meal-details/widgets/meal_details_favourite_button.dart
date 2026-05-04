import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Providers
import 'package:sfrigola/features/feature-meal-details/providers/update_favourite_provider.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_icon_button.dart';
import 'package:sfrigola/core/widgets/base_scaffold_messenger.dart';

class MealDetailsFavouriteButton extends ConsumerStatefulWidget {
  final Meal meal;

  const MealDetailsFavouriteButton({super.key, required this.meal});

  @override
  ConsumerState<MealDetailsFavouriteButton> createState() =>
      _MealDetailsFavouriteButtonState();
}

class _MealDetailsFavouriteButtonState
    extends ConsumerState<MealDetailsFavouriteButton> {
  final _cachedIsFavourite = ValueNotifier<bool>(false);

  Future<void> _toggleFavourite() async {
    final provider = ref.read(updateFavouriteProvider(widget.meal.id).notifier);
    final currentFav = _cachedIsFavourite.value;

    // Optimistic update
    _cachedIsFavourite.value = !currentFav;

    try {
      await provider.toggle();
      if (!mounted) return;
      BaseScaffoldMessenger.show(
        context,
        duration: const Duration(seconds: 1),
        message: currentFav
            ? AppLocale.getLabels(context).favouriteRemoved
            : AppLocale.getLabels(context).favouriteAdded,
        type: SnackBarType.info,
      );
    } catch (e) {
      // Rollback on error
      _cachedIsFavourite.value = currentFav;
      if (!mounted) return;
      BaseScaffoldMessenger.show(
        context,
        duration: const Duration(seconds: 1),
        message: AppLocale.errorFor(context, e),
        type: SnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFavouriteAsync = ref.watch(updateFavouriteProvider(widget.meal.id));

    return BaseIconButton(
      icon: _cachedIsFavourite.value
          ? PhosphorIconsFill.heart
          : PhosphorIconsRegular.heart,
      color: Colors.white,
      iconColor: AppColors.error,
      type: IconButtonType.filled,
      onPressed: isFavouriteAsync.isLoading ? null : _toggleFavourite,
    );
  }
}
