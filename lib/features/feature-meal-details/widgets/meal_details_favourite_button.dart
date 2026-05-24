import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Providers
import 'package:sfrigola/features/feature-favourites/providers/all_favourites_by_filter_provider.dart';
import 'package:sfrigola/features/feature-meal-details/providers/update_favourite_provider.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_icon_button.dart';
import 'package:sfrigola/core/widgets/base_scaffold_messenger.dart';

class MealDetailsFavouriteButton extends ConsumerStatefulWidget {
  final String mealId;
  final bool isFavourite;

  const MealDetailsFavouriteButton({
    super.key,
    required this.mealId,
    required this.isFavourite,
  });

  @override
  ConsumerState<MealDetailsFavouriteButton> createState() =>
      _MealDetailsFavouriteButtonState();
}

class _MealDetailsFavouriteButtonState
    extends ConsumerState<MealDetailsFavouriteButton> {
  late bool _isFav;
  late final ProviderContainer _container;

  @override
  void initState() {
    super.initState();
    _isFav = widget.isFavourite;
    _container = ProviderScope.containerOf(context, listen: false);
  }

  @override
  void dispose() {
    if (_isFav != widget.isFavourite) {
      _container.invalidate(allFavouritesByFilterProvider);
    }
    super.dispose();
  }

  void _onToggle() {
    final current = _isFav;
    // optimistic update
    setState(() => _isFav = !current);
    ref.read(updateFavouriteProvider(widget.mealId).notifier).toggle(current);
  }

  @override
  Widget build(BuildContext context) {
    final op = ref.watch(updateFavouriteProvider(widget.mealId));

    // Listen for operation results — show feedback and rollback on error.
    ref.listen(updateFavouriteProvider(widget.mealId), (previous, next) {
      if (!mounted) return;
      if (next is AsyncError) {
        // rollback optimistic update
        setState(() => _isFav = !_isFav);
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
          message: _isFav
              ? AppLocale.getLabels(context).favouriteAdded
              : AppLocale.getLabels(context).favouriteRemoved,
          type: _isFav ? SnackBarType.success : SnackBarType.info,
        );
      }
    });

    return BaseIconButton(
      icon: _isFav ? PhosphorIconsFill.heart : PhosphorIconsRegular.heart,
      color: Colors.white,
      iconColor: AppColors.error,
      type: IconButtonType.filled,
      tooltip: _isFav
          ? AppLocale.getLabels(context).tooltipRemoveFromFavourites
          : AppLocale.getLabels(context).tooltipAddToFavourites,
      onPressed: op.isLoading ? null : _onToggle,
    );
  }
}
