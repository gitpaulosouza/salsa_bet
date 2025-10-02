// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_stores.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoritesStore on _FavoritesStore, Store {
  Computed<List<String>>? _$favoritesOrderedComputed;

  @override
  List<String> get favoritesOrdered =>
      (_$favoritesOrderedComputed ??= Computed<List<String>>(
            () => super.favoritesOrdered,
            name: '_FavoritesStore.favoritesOrdered',
          ))
          .value;

  late final _$favoriteIdsAtom = Atom(
    name: '_FavoritesStore.favoriteIds',
    context: context,
  );

  @override
  ObservableSet<String> get favoriteIds {
    _$favoriteIdsAtom.reportRead();
    return super.favoriteIds;
  }

  @override
  set favoriteIds(ObservableSet<String> value) {
    _$favoriteIdsAtom.reportWrite(value, super.favoriteIds, () {
      super.favoriteIds = value;
    });
  }

  late final _$toggleAsyncAction = AsyncAction(
    '_FavoritesStore.toggle',
    context: context,
  );

  @override
  Future<void> toggle(String id) {
    return _$toggleAsyncAction.run(() => super.toggle(id));
  }

  late final _$_FavoritesStoreActionController = ActionController(
    name: '_FavoritesStore',
    context: context,
  );

  @override
  void _load() {
    final _$actionInfo = _$_FavoritesStoreActionController.startAction(
      name: '_FavoritesStore._load',
    );
    try {
      return super._load();
    } finally {
      _$_FavoritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoriteIds: ${favoriteIds},
favoritesOrdered: ${favoritesOrdered}
    ''';
  }
}
