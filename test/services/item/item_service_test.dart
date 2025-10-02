import 'package:flutter_test/flutter_test.dart';
import 'package:salsa_challenge/services/item/item_service.dart';

void main() {
  late ItemService service;

  setUp(() {
    service = MockItemService();
  });

  test('MockItemService retorna lista mockada de itens', () async {
    final items = await service.fetchItems();

    expect(items, isNotEmpty);
    expect(items.length, greaterThan(0));
    expect(items.first.id, 'poker');
    expect(items.last.id, 'roleta');
  });
}
