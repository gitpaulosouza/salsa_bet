import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:salsa_challenge/core/di/injector.dart';
import 'package:salsa_challenge/core/routes/app_router.dart';
import 'package:salsa_challenge/stores/theme/theme_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        themeMode: themeStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
