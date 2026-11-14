import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/l10n/generated/app_localizations.dart';
import 'core/l10n/l10n.dart';
import 'core/providers/app_providers.dart';
import 'core/security/app_lock.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/employees/presentation/employees_screen.dart';
import 'features/reports/presentation/reports_screen.dart';
import 'features/scanner/presentation/scanner_screen.dart';
import 'features/settings/presentation/settings_screen.dart';

class PointageProApp extends ConsumerWidget {
  const PointageProApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final locale = Locale(settings.languageCode);
    final themeMode = switch (settings.themeMode) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    return MaterialApp.router(
      title: settings.appName,
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.build(settings, Brightness.light),
      darkTheme: AppTheme.build(settings, Brightness.dark),
      themeMode: themeMode,
      routerConfig: appRouter,
      builder: (context, child) {
        return AppLockGate(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(
                settings.textScale.clamp(0.85, 1.3),
              ),
            ),
            child: child!,
          ),
        );
      },
    );
  }
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          RootShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/home', builder: (_, _) => const DashboardScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/scanner', builder: (_, _) => const ScannerScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/employees',
              builder: (_, _) => const EmployeesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/reports', builder: (_, _) => const ReportsScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (_, _) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class RootShell extends StatelessWidget {
  const RootShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: context.l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.qr_code_scanner),
            selectedIcon: const Icon(Icons.qr_code_scanner),
            label: context.l10n.navScanner,
          ),
          NavigationDestination(
            icon: const Icon(Icons.people_outline),
            selectedIcon: const Icon(Icons.people),
            label: context.l10n.navEmployees,
          ),
          NavigationDestination(
            icon: const Icon(Icons.bar_chart_outlined),
            selectedIcon: const Icon(Icons.bar_chart),
            label: context.l10n.navReports,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: context.l10n.navSettings,
          ),
        ],
      ),
    );
  }
}
