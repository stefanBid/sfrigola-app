import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import '../../helpers/app_colors.dart';
import '../../helpers/app_design.dart';
import '../../helpers/app_typography.dart';

// Project Layouts
import '../../layouts/app_bars/classic_app_bar.dart';
import '../../layouts/body/standard_page_layout.dart';

// Project Widgets
import '../../widgets/base_badge.dart';
import '../../widgets/base_button.dart';
import '../../widgets/base_image_container.dart';
import '../../widgets/base_value_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPageLayout(
      appBar: const ClassicAppBar(
        leading: Icon(PhosphorIconsBold.user),
        title: 'Profile',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // — Avatar & name
            Center(
              child: Column(
                children: [
                  const ClipRRect(
                    borderRadius: AppDesign.borderRadiusLg,
                    child: BaseImageContainer(
                      imageUrl: 'https://picsum.photos/id/64/200/200',
                      width: 96,
                      height: 96,
                    ),
                  ),
                  const SizedBox(height: AppDesign.gapItemSm),
                  Text('John Doe', style: AppTypography.of(context).heading2),
                  const SizedBox(height: AppDesign.gapItemXs),
                  Text(
                    'john.doe@example.com',
                    style: AppTypography.of(context).bodySecondary.copyWith(
                      color: AppColors.of(context).muted,
                    ),
                  ),
                  const SizedBox(height: AppDesign.gapItemSm),
                  Wrap(
                    spacing: AppDesign.gapInlineSm,
                    children: [
                      BaseBadge(
                        label: 'Admin',
                        icon: PhosphorIconsRegular.shieldCheck,
                        style: BadgeStyle(
                          color: AppColors.primary.withAlpha(40),
                          foregroundColor: AppColors.primary,
                        ),
                      ),
                      BaseBadge(
                        label: 'Pro',
                        icon: PhosphorIconsRegular.star,
                        style: BadgeStyle(
                          color: AppColors.warning.withAlpha(40),
                          foregroundColor: AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDesign.gapSectionLg),

            // — Stats
            Text('Stats', style: AppTypography.of(context).heading3),
            const SizedBox(height: AppDesign.gapItemSm),
            const Row(
              children: [
                Expanded(
                  child: BaseValueCard(label: 'Posts', value: '128'),
                ),
                SizedBox(width: AppDesign.gapInlineSm),
                Expanded(
                  child: BaseValueCard(label: 'Followers', value: '4.2K'),
                ),
                SizedBox(width: AppDesign.gapInlineSm),
                Expanded(
                  child: BaseValueCard(label: 'Following', value: '312'),
                ),
              ],
            ),
            const SizedBox(height: AppDesign.gapSectionLg),

            // — About
            Text('About', style: AppTypography.of(context).heading3),
            const SizedBox(height: AppDesign.gapItemSm),
            Text(
              'Flutter developer and design system enthusiast. '
              'I build clean, scalable mobile apps with a focus on '
              'great user experience and consistent UI patterns.',
              style: AppTypography.of(context).body,
            ),
            const SizedBox(height: AppDesign.gapSectionLg),

            // — Settings
            Text('Settings', style: AppTypography.of(context).heading3),
            const SizedBox(height: AppDesign.gapItemSm),
            _SettingsRow(
              icon: PhosphorIconsRegular.bell,
              label: 'Notifications',
              onTap: () {},
            ),
            _SettingsRow(
              icon: PhosphorIconsRegular.lock,
              label: 'Privacy & Security',
              onTap: () {},
            ),
            _SettingsRow(
              icon: PhosphorIconsRegular.palette,
              label: 'Appearance',
              onTap: () {},
            ),
            _SettingsRow(
              icon: PhosphorIconsRegular.question,
              label: 'Help & Support',
              onTap: () {},
            ),
            const SizedBox(height: AppDesign.gapSectionLg),

            // — Logout
            BaseButton(
              fullWidth: true,
              type: BaseButtonType.outlined,
              label: 'Log out',
              icon: PhosphorIconsRegular.signOut,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SettingsRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppDesign.borderRadiusXs,
      child: Padding(
        padding: AppDesign.paddingSymmetricMd,
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.of(context).muted),
            const SizedBox(width: AppDesign.gapInlineSm),
            Expanded(child: Text(label, style: AppTypography.of(context).body)),
            Icon(
              PhosphorIconsRegular.caretRight,
              size: 16,
              color: AppColors.of(context).muted,
            ),
          ],
        ),
      ),
    );
  }
}
