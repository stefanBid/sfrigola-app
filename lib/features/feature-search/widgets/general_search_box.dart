import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Providers
import 'package:sfrigola/features/feature-search/providers/searched_key_provider.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_input.dart';

class GeneralSearchBox extends ConsumerStatefulWidget {
  final VoidCallback? onBlurEmpty;

  /// Delay after the user stops typing before the search key is updated.
  final Duration debounceDuration;

  const GeneralSearchBox({
    super.key,
    this.onBlurEmpty,
    this.debounceDuration = const Duration(milliseconds: 500),
  });

  @override
  ConsumerState<GeneralSearchBox> createState() => _GeneralSearchBoxState();
}

class _GeneralSearchBoxState extends ConsumerState<GeneralSearchBox> {
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;
  Timer? _debounceTimer;
  bool _hasFocusedOnce = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _hasFocusedOnce = true;
    } else if (_hasFocusedOnce && _searchController.text.isEmpty) {
      widget.onBlurEmpty?.call();
    }
  }

  void _handleSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      ref
          .read(searchedKeyProvider.notifier)
          .change(value.isEmpty ? null : value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      controller: _searchController,
      autofocus: true,
      focusNode: _focusNode,
      hint: AppLocale.getLabels(context).homeSearchHint,
      prefixIcon: Icon(
        PhosphorIconsRegular.magnifyingGlass,
        size: AppDesign.iconSizeMd,
        color: AppColors.of(context).muted,
      ),
      onChanged: _handleSearchChanged,
    );
  }
}
