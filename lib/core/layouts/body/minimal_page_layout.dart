import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';

/// Minimal full-screen layout for auth flows (login, register).
///
/// Renders an optional [appBar] (typically [TransparentAppBar]) at the top,
/// followed by a scrollable, horizontally-padded body area.
///
/// [SafeArea] for the top is applied only when no [appBar] is provided.
/// Bottom safe area is always applied.
class MinimalPageLayout extends StatelessWidget {
  final Widget body;

  /// Optional app bar rendered above the scrollable content.
  /// Use [TransparentAppBar] for auth screens.
  final Widget? appBar;

  /// When true (default), applies [AppDesign.paddingPage] horizontal padding
  /// to the scrollable body.
  final bool hasPadding;

  const MinimalPageLayout({
    super.key,
    required this.body,
    this.appBar,
    this.hasPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasAppBar = appBar != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasAppBar) appBar!,
        Expanded(
          child: SingleChildScrollView(
            padding: hasPadding ? AppDesign.paddingPage : EdgeInsets.zero,
            child: SafeArea(top: !hasAppBar, child: body),
          ),
        ),
      ],
    );
  }
}
