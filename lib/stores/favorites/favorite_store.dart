import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'favorite_store.g.dart';

// ignore: invalid_use_of_private_type_in_public_api
class FavoritesStore = _FavoritesStore with _$FavoritesStore;

abstract class _FavoritesStore with Store {
  _FavoritesStore(this._box) {
    _load();
  }

  final Box _box;

  static const _key = 'favorite_ids';

  @observable
  ObservableSet<String> favoriteIds = ObservableSet.of({});

  @computed
  List<String> get favoritesOrdered => favoriteIds.toList()..sort();

  @action
  void _load() {
    final ids = (_box.get(_key, defaultValue: <String>[]) as List).cast<String>();
    favoriteIds = ObservableSet.of(ids);
  }

  @action
  Future<void> toggle(String id) async {
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }
    await _box.put(_key, favoriteIds.toList());
  }

  bool isFavorite(String id) => favoriteIds.contains(id);
}
