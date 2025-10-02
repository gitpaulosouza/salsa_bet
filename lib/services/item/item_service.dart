
import 'package:salsa_challenge/core/constants/app_assets.dart';
import 'package:salsa_challenge/models/item/item_model.dart';

abstract class ItemService {
  Future<List<Item>> fetchItems();
}

class MockItemService implements ItemService {
  @override
  Future<List<Item>> fetchItems() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return _mockItems.map((e) => Item.fromJson(e)).toList();
  }
}

final _mockItems = [
  {
    "id": "poker",
    "title": "Poker",
    "subtitle": "Mostre sua sorte",
    "imagePath": AppAssets.poker,
  },
  {
    "id": "bingo",
    "title": "Bingo",
    "subtitle": "Complete a cartela",
    "imagePath": AppAssets.bingo,
  },
  {
    "id": "slots",
    "title": "Slots",
    "subtitle": "Gire e ganhe",
    "imagePath": AppAssets.slots,
  },
  {
    "id": "blackjack",
    "title": "Blackjack",
    "subtitle": "21 é a meta",
    "imagePath": AppAssets.blackjack,
  },
  {
    "id": "roleta",
    "title": "Roleta",
    "subtitle": "Vermelho ou preto?",
    "imagePath": AppAssets.roleta,
  },
];