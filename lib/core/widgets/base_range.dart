import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

class BaseRange extends StatelessWidget {
  final String? label;
  final RangeValues values;
  final double min;
  final double max;
  final int? divisions;
  final String Function(double)? valueFormatter;
  final ValueChanged<RangeValues>? onChanged;

  const BaseRange({
    super.key,
    this.label,
    required this.values,
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
          Text(label!, style: typography.caption),
          const SizedBox(height: AppDesign.gapInlineSm),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_format(values.start), style: typography.caption),
            Text(_format(values.end), style: typography.caption),
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
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 10,
            ),
            rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
            showValueIndicator: ShowValueIndicator.onDrag,
            valueIndicatorColor: AppColors.primary,
            valueIndicatorTextStyle: typography.small.copyWith(
              color: Colors.white,
            ),
          ),
          child: RangeSlider(
            values: values,
            min: min,
            max: max,
            divisions: divisions,
            labels: RangeLabels(_format(values.start), _format(values.end)),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
