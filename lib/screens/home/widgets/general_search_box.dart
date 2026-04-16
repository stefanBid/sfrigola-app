import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_locale.dart';

// Project Widgets
import 'package:sfrigola/widgets/base_input.dart';

class GeneralSearchBox extends StatefulWidget {
  final void Function(String)? onChanged;

  /// Delay after the user stops typing before [onChanged] is fired.
  final Duration debounceDuration;

  const GeneralSearchBox({
    super.key,
    this.onChanged,
    this.debounceDuration = const Duration(milliseconds: 500),
  });

  @override
  State<GeneralSearchBox> createState() => _GeneralSearchBoxState();
}

class _GeneralSearchBoxState extends State<GeneralSearchBox> {
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
      widget.onChanged?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      controller: _searchController,
      hint: AppLocale.getLabels(context).homeSearchHint,
      prefixIcon: Icon(
        PhosphorIconsRegular.magnifyingGlass,
        size: 20,
        color: AppColors.of(context).muted,
      ),
      onChanged: _handleSearchChanged,
    );
  }
}
