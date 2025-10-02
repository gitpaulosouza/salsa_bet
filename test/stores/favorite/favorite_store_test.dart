import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive/hive.dart';
import 'package:salsa_challenge/stores/favorites/favorite_store.dart';

class MockBox extends Mock implements Box {}

void main() {
  late MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
  });

  group('FavoritesStore', () {
    test('load inicializa favoriteIds a partir do Box', () {
      when(() => mockBox.get('favorite_ids', defaultValue: <String>[]))
          .thenReturn(['item1', 'item2']);

      final store = FavoritesStore(mockBox);

      expect(store.favoriteIds, containsAll(['item1', 'item2']));
    });

    test('toggle adiciona item quando não existe', () async {
      when(() => mockBox.get('favorite_ids', defaultValue: <String>[]))
          .thenReturn([]);
      when(() => mockBox.put(any(), any()))
          .thenAnswer((_) async {});

      final store = FavoritesStore(mockBox);

      await store.toggle('item1');

      expect(store.isFavorite('item1'), isTrue);
      verify(() => mockBox.put('favorite_ids', ['item1'])).called(1);
    });

    test('toggle remove item quando já existe', () async {
      when(() => mockBox.get('favorite_ids', defaultValue: <String>[]))
          .thenReturn(['item1']);
      when(() => mockBox.put(any(), any()))
          .thenAnswer((_) async {});

      final store = FavoritesStore(mockBox);

      await store.toggle('item1');

      expect(store.isFavorite('item1'), isFalse);
      verify(() => mockBox.put('favorite_ids', <String>[])).called(1);
    });

    test('favoritesOrdered retorna lista ordenada', () {
      when(() => mockBox.get('favorite_ids', defaultValue: <String>[]))
          .thenReturn(['c', 'a', 'b']);

      final store = FavoritesStore(mockBox);

      final ordered = store.favoritesOrdered;

      expect(ordered, ['a', 'b', 'c']);
    });
  });
}
