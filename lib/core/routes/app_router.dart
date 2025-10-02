import 'package:go_router/go_router.dart';
import 'package:salsa_challenge/core/di/injector.dart';
import 'package:salsa_challenge/stores/login/login_store.dart';
import 'package:salsa_challenge/ui/home/home_page.dart';
import 'package:salsa_challenge/ui/login/login_page.dart';
import 'package:salsa_challenge/ui/settings/settings_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(
        loginStore: getIt<LoginStore>(),
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
