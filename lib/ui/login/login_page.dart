import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:salsa_challenge/core/constants/app_assets.dart';
import 'package:salsa_challenge/stores/login/login_store.dart';

class LoginPage extends StatefulWidget {
  final LoginStore loginStore;

  const LoginPage({super.key, required this.loginStore});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginStore get loginStore => widget.loginStore;

  @override
  void initState() {
    super.initState();
    loginStore.loadLoginStatus().then((_) {
      if (loginStore.isLoggedIn) {
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              child: Image.asset(
                AppAssets.favicon,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 40),

            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final success = await loginStore.login(
                    _usernameController.text,
                    _passwordController.text,
                  );
                  if (success) {
                    context.go('/home');
                  }
                },
                child: const Text("Login"),
              ),
            ),

            const SizedBox(height: 24),

            Observer(
              builder: (_) {
                if (loginStore.errorMessage != null) {
                  return Text(
                    loginStore.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
