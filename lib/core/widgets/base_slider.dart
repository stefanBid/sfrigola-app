import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

class BaseSlider extends StatelessWidget {
  final String? label;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String Function(double)? valueFormatter;
  final ValueChanged<double>? onChanged;

  const BaseSlider({
    super.key,
    this.label,
    required this.value,
    required this.min,
    required this.max,
    this.divisions,
    this.valueFormatter,
    this.onChanged,
  });

  String _format(double v) =>
      valueFormatter != null ? valueFormatter!(v) : v.toStringAsFixed(0);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final typography = AppTypography.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: typography.bodyMedium),
          const SizedBox(height: AppDesign.gapInlineSm),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_format(min), style: typography.bodyMedium),
            Text(
              _format(value),
              style: typography.bodyMedium.copyWith(color: AppColors.primary),
            ),
            Text(_format(max), style: typography.bodyMedium),
          ],
        ),
        const SizedBox(height: AppDesign.gapItemXs),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: colors.muted,
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withAlpha(30),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            trackShape: const RoundedRectSliderTrackShape(),
            showValueIndicator: ShowValueIndicator.onDrag,
            valueIndicatorColor: AppColors.primary,
            valueIndicatorTextStyle: typography.bodyMedium.copyWith(
              color: Colors.white,
            ),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: _format(value),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

