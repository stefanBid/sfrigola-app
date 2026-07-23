import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
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
  final double initialRating;

  const RateMealForm({
    super.key,
    required this.mealId,
    required this.initialRating,
  });

  @override
  ConsumerState<RateMealForm> createState() => _RateMealFormState();
}

class _RateMealFormState extends ConsumerState<RateMealForm> {
  // Confirmed rating — starts from widget prop, updated optimistically.
  late double _confirmedRating;
  // Saved before each optimistic update, restored on error.
  double? _previousRating;
  // Live preview during drag — discarded on drag cancel, committed on drag end.
  double? _previewRating;

  final _rowKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _confirmedRating = widget.initialRating;
  }

  // Converts a horizontal offset to a rating value.
  // [halfStars] true → rounds to nearest 0.5 (drag). false → rounds to nearest 1.0 (tap).
  double _ratingFromDx(double dx, {bool halfStars = false}) {
    final box = _rowKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return 1.0;
    final raw = (dx / box.size.width * 5).clamp(0.0, 5.0);
    if (halfStars) return ((raw * 2).round() / 2).clamp(0.5, 5.0);
    return raw.ceil().clamp(1, 5).toDouble();
  }

  void _submitRating(double rating) {
    _previousRating = _confirmedRating;
    setState(() {
      // optimistic update
      _confirmedRating = rating;
      _previewRating = null;
    });
    ref.read(updateRatingProvider(widget.mealId).notifier).rate(rating);
  }

  @override
  Widget build(BuildContext context) {
    final ratingOp = ref.watch(updateRatingProvider(widget.mealId));

    // Listen for operation results — show feedback and rollback on error.
    ref.listen(updateRatingProvider(widget.mealId), (previous, next) {
      if (!mounted) return;
      if (next is AsyncError) {
        setState(
          () => _confirmedRating = _previousRating ?? widget.initialRating,
        );
        BaseScaffoldMessenger.show(
          context,
          message: AppLocale.errorFor(context, next.error),
          type: SnackBarType.error,
          duration: const Duration(seconds: 1),
        );
      } else if (next is AsyncData && previous?.isLoading == true) {
        BaseScaffoldMessenger.show(
          context,
          message: AppLocale.getLabels(context).rateMealSuccess,
          type: SnackBarType.success,
          duration: const Duration(seconds: 1),
        );
      }
    });

    // Priority: drag preview > optimistic confirmed value.
    final displayRating = _previewRating ?? _confirmedRating;
    final isLoading = ratingOp.isLoading;

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
            icon = LucideIcons.star;
            color = AppColors.warning;
          } else if (displayRating >= halfValue) {
            icon = LucideIcons.starHalf;
            color = AppColors.warning;
          } else {
            icon = LucideIcons.star;
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
