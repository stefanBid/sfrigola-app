import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import '../../helpers/app_colors.dart';
import '../../helpers/app_design.dart';
import '../../helpers/app_typography.dart';

// Project Layouts
import '../../layouts/body/hero_page_layout.dart';

// Project Widgets
import '../../widgets/base_badge.dart';

class DetailsScreen extends StatelessWidget {
  final String detailId;

  const DetailsScreen({super.key, required this.detailId});

  @override
  Widget build(BuildContext context) {
    return HeroPageLayout(
      imageUrl: 'https://picsum.photos/id/$detailId/400/300',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // — Title & subtitle
          Text('Item $detailId', style: AppTypography.of(context).heading1),
          const SizedBox(height: AppDesign.gapItemXs),
          Text(
            'Detail view — item #$detailId',
            style: AppTypography.of(
              context,
            ).bodySecondary.copyWith(color: AppColors.of(context).muted),
          ),
          const SizedBox(height: AppDesign.gapSectionSm),

          // — Badges
          Wrap(
            spacing: AppDesign.gapInlineSm,
            runSpacing: AppDesign.gapInlineSm,
            children: [
              BaseBadge(
                label: 'Template',
                icon: PhosphorIconsRegular.blueprint,
                style: BadgeStyle(
                  color: AppColors.primary.withAlpha(40),
                  foregroundColor: AppColors.primary,
                ),
              ),
              BaseBadge(
                label: 'Detail',
                icon: PhosphorIconsRegular.listMagnifyingGlass,
                style: BadgeStyle(
                  color: AppColors.secondary.withAlpha(40),
                  foregroundColor: AppColors.secondary,
                ),
              ),
              BaseBadge(
                label: 'Hero Layout',
                icon: PhosphorIconsRegular.image,
                style: BadgeStyle(
                  color: AppColors.success.withAlpha(40),
                  foregroundColor: AppColors.success,
                ),
              ),
              BaseBadge(
                label: 'Outlined',
                icon: PhosphorIconsRegular.tag,
                style: BadgeStyle(
                  color: AppColors.of(context).muted,
                  variant: BadgeVariant.outlined,
                  foregroundColor: AppColors.of(context).muted,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesign.gapSectionMd),

          // — Description
          Text('About this screen', style: AppTypography.of(context).heading3),
          const SizedBox(height: AppDesign.gapItemSm),
          Text(
            'This is the detail screen of the template. '
            'It is reached by tapping any card on the Home screen, '
            'which passes a typed param (detailId) via AppRouter.goDeep.\n\n'
            'The layout uses HeroPageLayout: the image fills the top portion '
            'of the screen and the content card slides over it with rounded '
            'top corners. A back button is overlaid on the image via '
            'TransparentAppBar.\n\n'
            'In a real project, replace the dummy data with a model fetched '
            'from a service, populate the badges with meaningful tags, and '
            'extend the body with all the detail content your use case requires.'
            ' The template is designed to be a starting point for any detail-like screen,'
            ' allowing you to customize and expand it according to your needs.',
            style: AppTypography.of(context).body,
          ),
        ],
      ),
    );
  }
}
