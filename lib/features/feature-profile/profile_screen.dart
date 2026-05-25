import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/core/layouts/body/message_page_layout.dart';
import 'package:sfrigola/core/layouts/body/standard_page_layout.dart';

// Project Providers
import 'package:sfrigola/core/providers/current_user_provider.dart';
import 'package:sfrigola/core/providers/repository_provider.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_button.dart';
import 'package:sfrigola/core/widgets/base_icon_button.dart';

// Feature Widgets
import 'package:sfrigola/features/feature-profile/widgets/profile_change_password_section.dart';
import 'package:sfrigola/features/feature-profile/widgets/profile_header.dart';
import 'package:sfrigola/features/feature-profile/widgets/profile_stats_section.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocale.getLabels(context);
    final typo = AppTypography.of(context);
    final userAsync = ref.watch(currentUserProvider);
    final isLoggedIn = userAsync.value != null;

    return StandardPageLayout(
      appBar: ClassicAppBar(
        leading: const Icon(PhosphorIconsBold.user),
        title: l.profileTitle,
        actions: isLoggedIn
            ? [
                BaseIconButton(
                  icon: PhosphorIconsRegular.signOut,
                  tooltip: l.profileLogout,
                  onPressed: () async {
                    await ref.read(authRepositoryProvider).logout();
                    ref.invalidate(currentUserProvider);
                    if (context.mounted) context.go('/login');
                  },
                ),
              ]
            : null,
      ),
      body: switch (userAsync) {
        AsyncData(:final value) when value == null => MessagePageLayout(
          icon: PhosphorIconsRegular.user,
          message: l.profileLoginRequired,
          type: MessagePageType.muted,
          customButton: BaseButton(
            label: l.profileLoginButton,
            onPressed: () => context.push('/login'),
          ),
        ),
        AsyncData() => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),
              const SizedBox(height: AppDesign.gapSectionLg),

              Text(l.profileSectionStats, style: typo.heading3),
              const SizedBox(height: AppDesign.gapItemSm),
              const ProfileStatsSection(),
              const SizedBox(height: AppDesign.gapSectionLg),

              Text(l.profileSectionSettings, style: typo.heading3),
              const SizedBox(height: AppDesign.gapItemSm),
              const ProfileChangePasswordSection(),
              const SizedBox(height: AppDesign.gapSectionLg),
            ],
          ),
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
