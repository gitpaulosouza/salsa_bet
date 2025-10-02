import 'package:flutter/material.dart';
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
    final loginStore = getIt<LoginStore>();
    final favStore = getIt<FavoritesStore>();
    final itemService = getIt<ItemService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            tooltip: 'Configurações',
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
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
                crossAxisCount: 1,
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
    );
  }
}
