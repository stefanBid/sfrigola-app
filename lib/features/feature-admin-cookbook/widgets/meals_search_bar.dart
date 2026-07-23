import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Providers
import 'package:sfrigola/core/providers/search_key_provider.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_input.dart';

class MealsSearchBar extends ConsumerStatefulWidget {
  /// Delay after the user stops typing before the search key is updated.
  final Duration debounceDuration;

  const MealsSearchBar({
    super.key,
    this.debounceDuration = const Duration(milliseconds: 500),
  });

  @override
  ConsumerState<MealsSearchBar> createState() => _MealsSearchBarState();
}

class _MealsSearchBarState extends ConsumerState<MealsSearchBar> {
  late final TextEditingController _searchController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      ref
          .read(searchKeyProvider(SearchScope.adminCookbook).notifier)
          .change(value.isEmpty ? null : value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      controller: _searchController,
      hint: AppLocale.getLabels(context).cookbookSearchHint,
      prefixIcon: Icon(
        LucideIcons.search,
        size: AppDesign.iconSizeMd,
        color: AppColors.of(context).muted,
      ),
      onChanged: _handleSearchChanged,
    );
  }
}
