import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Models
import 'package:sfrigola/core/models/user.dart';

// Project Providers
import 'package:sfrigola/core/providers/current_user_provider.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_badge.dart';
import 'package:sfrigola/core/widgets/base_image_container.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typo = AppTypography.of(context);
    final colors = AppColors.of(context);
    final l = AppLocale.getLabels(context);
    final user = ref.watch(currentUserProvider).value;

    final displayName = user != null
        ? '${user.name}${user.surname != null ? ' ${user.surname}' : ''}'
        : '';

    final roleLabel = switch (user?.type) {
      UserType.admin => l.profileUserTypeAdmin,
      UserType.chef => l.profileUserTypeChef,
      _ => l.profileUserTypeConsumer,
    };

    final roleIcon = switch (user?.type) {
      UserType.admin => LucideIcons.shieldCheck,
      UserType.chef => LucideIcons.chefHat,
      _ => LucideIcons.user,
    };

    return Center(
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
          Text(displayName, style: typo.heading2),
          if (user != null) ...[
            const SizedBox(height: AppDesign.gapItemXs),
            Text(
              user.email,
              style: typo.bodySecondary.copyWith(color: colors.muted),
            ),
            const SizedBox(height: AppDesign.gapItemSm),
            BaseBadge(
              label: roleLabel,
              icon: roleIcon,
              style: BadgeStyle(
                color: AppColors.primary.withAlpha(40),
                foregroundColor: AppColors.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

