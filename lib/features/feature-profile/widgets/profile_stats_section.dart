import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Models
import 'package:sfrigola/core/models/user.dart';

// Project Providers
import 'package:sfrigola/core/providers/current_user_provider.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_value_card.dart';

// Feature Providers
import 'package:sfrigola/features/feature-profile/providers/user_stats_provider.dart';

class ProfileStatsSection extends ConsumerWidget {
  const ProfileStatsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocale.getLabels(context);
    final statsAsync = ref.watch(userStatsProvider);
    final user = ref.watch(currentUserProvider).value;
    final isChef = user?.type == UserType.chef;

    final favouritesValue = statsAsync.when(
      data: (s) => s.favouritesCount.toString(),
      loading: () => '—',
      error: (_, _) => '—',
    );

    final recipesValue = statsAsync.when(
      data: (s) => s.recipesCount.toString(),
      loading: () => '—',
      error: (_, _) => '—',
    );

    return Row(
      children: [
        Expanded(
          child: BaseValueCard(
            label: l.profileStatsFavourites,
            value: favouritesValue,
          ),
        ),
        if (isChef) ...[
          const SizedBox(width: AppDesign.gapInlineSm),
          Expanded(
            child: BaseValueCard(
              label: l.profileStatsRecipes,
              value: recipesValue,
            ),
          ),
        ],
      ],
    );
  }
}
