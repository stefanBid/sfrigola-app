import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Providers
import 'package:sfrigola/features/feature-meal-details/providers/update_rating_provider.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_scaffold_messenger.dart';

class RateMealForm extends ConsumerStatefulWidget {
  final String mealId;

  const RateMealForm({super.key, required this.mealId});

  @override
  ConsumerState<RateMealForm> createState() => _RateMealFormState();
}

class _RateMealFormState extends ConsumerState<RateMealForm> {
  // Confirmed rating after a successful API call (optimistic).
  double? _cachedRating;
  // Live preview during drag — discarded on drag cancel, committed on drag end.
  double? _previewRating;

  final _rowKey = GlobalKey();

  // Converts a horizontal offset to a rating value.
  // [halfStars] true → rounds to nearest 0.5 (drag). false → rounds to nearest 1.0 (tap).
  double _ratingFromDx(double dx, {bool halfStars = false}) {
    final box = _rowKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return 1.0;
    final raw = (dx / box.size.width * 5).clamp(0.0, 5.0);
    if (halfStars) return ((raw * 2).round() / 2).clamp(0.5, 5.0);
    return raw.ceil().clamp(1, 5).toDouble();
  }

  Future<void> _submitRating(double rating) async {
    final provider = ref.read(updateRatingProvider(widget.mealId).notifier);
    final previous = _cachedRating;

    setState(() {
      _cachedRating = rating;
      _previewRating = null;
    });

    try {
      await provider.rate(rating);
      if (!mounted) return;
      BaseScaffoldMessenger.show(
        context,
        message: AppLocale.getLabels(context).rateMealSuccess,
        type: SnackBarType.success,
        duration: const Duration(seconds: 1),
      );
    } catch (e) {
      // Rollback
      if (!mounted) return;
      setState(() => _cachedRating = previous);
      BaseScaffoldMessenger.show(
        context,
        message: AppLocale.errorFor(context, e),
        type: SnackBarType.error,
        duration: const Duration(seconds: 1),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ratingAsync = ref.watch(updateRatingProvider(widget.mealId));

    // Priority: drag preview > optimistic cached > provider value.
    final displayRating =
        _previewRating ?? _cachedRating ?? ratingAsync.value ?? 0.0;
    final isLoading = ratingAsync.isLoading;

    return GestureDetector(
      // Tap: full-star precision only.
      onTapUp: isLoading
          ? null
          : (d) => _submitRating(_ratingFromDx(d.localPosition.dx)),
      // Drag: half-star precision — update preview live without calling the API.
      onHorizontalDragUpdate: isLoading
          ? null
          : (d) => setState(
              () => _previewRating = _ratingFromDx(
                d.localPosition.dx,
                halfStars: true,
              ),
            ),
      // Drag end: commit the preview value.
      onHorizontalDragEnd: isLoading
          ? null
          : (_) {
              if (_previewRating != null) _submitRating(_previewRating!);
            },
      // Drag cancel: discard preview without submitting.
      onHorizontalDragCancel: () => setState(() => _previewRating = null),
      child: Row(
        key: _rowKey,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          final halfValue = index + 0.5;
          final fullValue = (index + 1).toDouble();

          final IconData icon;
          final Color color;
          if (displayRating >= fullValue) {
            icon = PhosphorIconsFill.star;
            color = AppColors.warning;
          } else if (displayRating >= halfValue) {
            icon = PhosphorIconsFill.starHalf;
            color = AppColors.warning;
          } else {
            icon = PhosphorIconsRegular.star;
            color = AppColors.of(context).muted;
          }

          return Padding(
            padding: const EdgeInsets.only(right: AppDesign.gapInlineXs),
            child: Icon(icon, size: AppDesign.iconSizeLg, color: color),
          );
        }),
      ),
    );
  }
}
