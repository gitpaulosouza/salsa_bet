import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:salsa_challenge/services/item/item_service.dart';
import 'package:salsa_challenge/services/login/login_service.dart';
import 'package:salsa_challenge/stores/favorites/favorite_store.dart';
import 'package:salsa_challenge/stores/login/login_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  await Hive.initFlutter();
  final favoritesBox = await Hive.openBox('favorites_box');

  // Services
  getIt.registerLazySingleton<LoginService>(() => LoginServiceImpl(prefs));
  getIt.registerLazySingleton<ItemService>(() => MockItemService());

  // Stores
  getIt.registerFactory<LoginStore>(() => LoginStore(getIt<LoginService>()));
  getIt.registerLazySingleton<FavoritesStore>(() => FavoritesStore(favoritesBox));
}
