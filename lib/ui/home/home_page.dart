import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salsa_challenge/core/di/injector.dart';
import 'package:salsa_challenge/stores/login/login_store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginStore = getIt<LoginStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await loginStore.logout();
              context.go('/'); // volta pro login
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Bem-vindo à Home!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
