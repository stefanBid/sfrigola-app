import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';

/// Animated skeleton for the [ManageMealForm] in edit mode.
/// Mirrors the form structure: General info → Recipe details → Dietary info → action bar.
class ManageMealFormSkeleton extends StatefulWidget {
  const ManageMealFormSkeleton({super.key});

  @override
  State<ManageMealFormSkeleton> createState() => _ManageMealFormSkeletonState();
}

class _ManageMealFormSkeletonState extends State<ManageMealFormSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _opacity = Tween<double>(
      begin: 0.3,
      end: 0.55,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ── Primitives ────────────────────────────────────────────────────────────

  Widget _bar({
    required BuildContext context,
    required double width,
    required double height,
    BorderRadius? borderRadius,
    bool useSurface = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: useSurface
            ? AppColors.of(context).surface
            : AppColors.of(context).muted,
        borderRadius: borderRadius ?? AppDesign.borderRadiusXXs,
      ),
    );
  }

  // ── Composites ────────────────────────────────────────────────────────────

  /// Mimics a GcSectionView header: icon placeholder + title bar.
  Widget _sectionHeader(BuildContext context) {
    return Row(
      children: [
        _bar(
          context: context,
          width: AppDesign.iconSizeLg,
          height: AppDesign.iconSizeLg,
        ),
        const SizedBox(width: AppDesign.gapInlineSm),
        _bar(context: context, width: 140, height: 18),
      ],
    );
  }

  /// Mimics a BaseFormField (label + input box).
  Widget _inputField(BuildContext context, {double height = 48}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _bar(context: context, width: 110, height: 12),
        const SizedBox(height: AppDesign.gapInlineSm),
        _bar(
          context: context,
          width: double.infinity,
          height: height,
          borderRadius: AppDesign.borderRadiusXs,
          useSurface: true,
        ),
      ],
    );
  }

  /// Mimics the duration BaseSlider (label + track bar).
  Widget _sliderField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _bar(context: context, width: 190, height: 12),
        const SizedBox(height: AppDesign.gapItemSm),
        _bar(
          context: context,
          width: double.infinity,
          height: 32,
          borderRadius: AppDesign.borderRadiusLg,
          useSurface: true,
        ),
      ],
    );
  }

  /// Mimics a single BaseCheckbox row.
  Widget _checkboxRow(BuildContext context, double labelWidth) {
    return Row(
      children: [
        _bar(
          context: context,
          width: 20,
          height: 20,
          borderRadius: AppDesign.borderRadiusXXs,
          useSurface: true,
        ),
        const SizedBox(width: AppDesign.gapInlineSm),
        _bar(context: context, width: labelWidth, height: 14),
      ],
    );
  }

  /// Mimics the DietaryInfo bordered container with 4 checkbox rows.
  Widget _dietarySection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.of(context).muted),
        borderRadius: AppDesign.borderRadiusSm,
      ),
      padding: AppDesign.paddingLg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _checkboxRow(context, 90),
          const SizedBox(height: AppDesign.gapItemMd),
          _checkboxRow(context, 105),
          const SizedBox(height: AppDesign.gapItemMd),
          _checkboxRow(context, 60),
          const SizedBox(height: AppDesign.gapItemMd),
          _checkboxRow(context, 80),
        ],
      ),
    );
  }

  /// Mimics the FormActionBar (two full-width buttons).
  Widget _actionBar(BuildContext context) {
    final bottomSpacing = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: AppDesign.paddingLg.copyWith(
        bottom: bottomSpacing + AppDesign.gapSectionMd,
      ),
      color: AppColors.of(context).bottomBar,
      child: Row(
        children: [
          Expanded(
            child: _bar(
              context: context,
              width: double.infinity,
              height: 46,
              borderRadius: AppDesign.borderRadiusXs,
              useSurface: true,
            ),
          ),
          const SizedBox(width: AppDesign.gapInlineMd),
          Expanded(
            child: _bar(
              context: context,
              width: double.infinity,
              height: 46,
              borderRadius: AppDesign.borderRadiusXs,
              useSurface: true,
            ),
          ),
        ],
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: AppDesign.paddingLg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── General info ─────────────────────────────────────
                    _sectionHeader(context),
                    const SizedBox(height: AppDesign.gapSectionXs),
                    _inputField(context),
                    const SizedBox(height: AppDesign.gapSectionMd),
                    _inputField(context),
                    const SizedBox(height: AppDesign.gapSectionMd),
                    _inputField(context, height: 96),

                    const SizedBox(height: AppDesign.gapSectionLg),

                    // ── Recipe details ────────────────────────────────────
                    _sectionHeader(context),
                    const SizedBox(height: AppDesign.gapSectionXs),
                    _inputField(context),
                    const SizedBox(height: AppDesign.gapSectionMd),
                    _inputField(context),
                    const SizedBox(height: AppDesign.gapSectionMd),
                    _inputField(context),
                    const SizedBox(height: AppDesign.gapSectionMd),
                    _sliderField(context),

                    const SizedBox(height: AppDesign.gapSectionLg),

                    // ── Dietary info ──────────────────────────────────────
                    _sectionHeader(context),
                    const SizedBox(height: AppDesign.gapSectionXs),
                    _dietarySection(context),

                    const SizedBox(height: AppDesign.gapSectionSm),
                  ],
                ),
              ),
            ),
          ),
          _actionBar(context),
        ],
      ),
    );
  }
}

