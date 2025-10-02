import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:salsa_challenge/core/di/injector.dart';
import 'package:salsa_challenge/models/item/item_model.dart';
import 'package:salsa_challenge/services/item/item_service.dart';
import 'package:salsa_challenge/stores/favorites/favorite_store.dart';
import 'package:salsa_challenge/stores/login/login_store.dart';
import 'package:salsa_challenge/ui/home/widgets/item_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favStore = getIt<FavoritesStore>();
    final itemService = getIt<ItemService>();

    Future<bool> showConfirmExitDialog() async {
      bool? exit = await showDialog(
        context: context,
        barrierDismissible: false,
        routeSettings: const RouteSettings(name: '/exit_from_app'),
        builder: (BuildContext context) {

          return AlertDialog(
            title: const Text('Sair do aplicativo'),
            content: const Text('Tem certeza que deseja sair?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Sair'),
              ),
            ],
          );
        },
      );

      return exit ?? false;
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldExit = await showConfirmExitDialog();
          if (shouldExit) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              tooltip: 'Configurações',
              icon: const Icon(Icons.settings, size: 32,),
              onPressed: () => context.push('/settings'),
            ),
          ],
        ),
        body: FutureBuilder<List<Item>>(
          future: itemService.fetchItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum item disponível'));
            }

            final items = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (_, i) {
                  final item = items[i];
                  return Observer(
                    builder: (BuildContext context) {
                      final isFavorite = favStore.isFavorite(item.id);
                      return ItemCard(
                        item: item,
                        isFavorite: isFavorite,
                        onToggleFavorite: () => favStore.toggle(item.id),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
