import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import '../helpers/app_colors.dart';
import '../helpers/app_router.dart';
import '../helpers/app_design.dart';

class _TabItem {
  final AppTypedRoute route;
  final String label;
  final IconData icon;
  final IconData? activeIcon;

  const _TabItem({
    required this.route,
    required this.label,
    required this.icon,
    this.activeIcon,
  });
}

class AppLayout extends StatelessWidget {
  final Widget child;
  final bool withBottomNav;

  const AppLayout({super.key, required this.child, this.withBottomNav = true});

  List<_TabItem> get _tabs => [
    const _TabItem(
      route: AppRouter.home,
      label: 'Home',
      icon: PhosphorIconsBold.house,
      activeIcon: PhosphorIconsFill.house,
    ),
    const _TabItem(
      route: AppRouter.forms,
      label: 'Forms',
      icon: PhosphorIconsBold.fileText,
      activeIcon: PhosphorIconsFill.fileText,
    ),
    const _TabItem(
      route: AppRouter.profile,
      label: 'Profile',
      icon: PhosphorIconsBold.user,
      activeIcon: PhosphorIconsFill.user,
    ),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = _tabs.toList().indexWhere(
      (r) => location.startsWith(r.route.path),
    );
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);

    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: child,
      ),
      bottomNavigationBar: withBottomNav
          ? Container(
              height: 48 + MediaQuery.of(context).padding.bottom,
              padding: EdgeInsets.only(
                top: AppDesign.gapItemXs,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              decoration: BoxDecoration(
                color: AppColors.of(context).bottomBar,
                border: Border(
                  top: BorderSide(
                    color: AppColors.of(context).muted.withAlpha(30),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _tabs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final tab = entry.value;
                  final isActive = index == currentIndex;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => AppRouter.goTo(context, tab.route),
                      behavior: HitTestBehavior.opaque,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: AppDesign.paddingSm,
                          decoration: BoxDecoration(
                            borderRadius: AppDesign.borderRadiusXs,
                            color: isActive
                                ? AppColors.of(context).muted.withAlpha(80)
                                : Colors.transparent,
                          ),
                          child: Icon(
                            isActive ? tab.activeIcon ?? tab.icon : tab.icon,
                            color: isActive
                                ? AppColors.primary
                                : AppColors.of(context).muted,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          : null,
    );
  }
}
