import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Providers
import 'package:sfrigola/features/feature-meal-details/providers/update_favourite_provider.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_icon_button.dart';
import 'package:sfrigola/core/widgets/base_scaffold_messenger.dart';

class MealDetailsFavouriteButton extends ConsumerStatefulWidget {
  final String mealId;

  const MealDetailsFavouriteButton({super.key, required this.mealId});

  @override
  ConsumerState<MealDetailsFavouriteButton> createState() =>
      _MealDetailsFavouriteButtonState();
}

class _MealDetailsFavouriteButtonState
    extends ConsumerState<MealDetailsFavouriteButton> {
  // Cached value for optimistic icon rendering — mirrors UpdateFavourite provider.
  bool? _cachedIsFavourite;

  Future<void> _toggleFavourite() async {
    final provider = ref.read(updateFavouriteProvider(widget.mealId).notifier);
    final currentFav = _cachedIsFavourite ?? false;

    // Optimistic update
    setState(() => _cachedIsFavourite = !currentFav);

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
      if (!mounted) return;
      setState(() => _cachedIsFavourite = currentFav);
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
    final isFavouriteAsync = ref.watch(updateFavouriteProvider(widget.mealId));

    // Sync cached value on first load (or after a hot-reload).
    final displayFav = _cachedIsFavourite ?? isFavouriteAsync.value ?? false;

    return BaseIconButton(
      icon: displayFav ? PhosphorIconsFill.heart : PhosphorIconsRegular.heart,
      color: Colors.white,
      iconColor: AppColors.error,
      type: IconButtonType.filled,
      onPressed: isFavouriteAsync.isLoading ? null : _toggleFavourite,
    );
  }
}
