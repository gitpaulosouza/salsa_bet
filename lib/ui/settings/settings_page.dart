import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:salsa_challenge/core/di/injector.dart';
import 'package:salsa_challenge/stores/login/login_store.dart';
import 'package:salsa_challenge/stores/theme/theme_store.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeStore = getIt<ThemeStore>();
    final loginStore = getIt<LoginStore>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Observer(
                  builder:
                      (_) => SwitchListTile(
                        title: const Text('Tema escuro'),
                        value: themeStore.isDarkMode,
                        onChanged: (_) => themeStore.toggleTheme(),
                      ),
                ),
                const Divider(),
                const ListTile(
                  title: Text('Usuário logado'),
                  subtitle: Text('salsa'),
                  leading: Icon(Icons.person, size: 38),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      onPressed: () async {
                        await loginStore.logout();
                        if (context.mounted) context.go('/');
                      },
                      icon: const Icon(Icons.logout),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsetsGeometry.all(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
