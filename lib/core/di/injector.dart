import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:salsa_challenge/services/item/item_service.dart';
import 'package:salsa_challenge/services/login/login_service.dart';
import 'package:salsa_challenge/services/theme/theme_service.dart';
import 'package:salsa_challenge/stores/favorites/favorite_store.dart';
import 'package:salsa_challenge/stores/login/login_store.dart';
import 'package:salsa_challenge/stores/theme/theme_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  await Hive.initFlutter();
  final favoritesBox = await Hive.openBox('favorites_box');

  getIt.registerSingleton<SharedPreferences>(prefs);

  // Services
  getIt.registerLazySingleton<LoginService>(() => LoginServiceImpl(getIt()));
  getIt.registerLazySingleton<ItemService>(() => MockItemService());
  getIt.registerLazySingleton<ThemeService>(() => ThemeServiceImpl(getIt()));

  // Stores
  getIt.registerFactory<LoginStore>(() => LoginStore(getIt()));
  getIt.registerLazySingleton<FavoritesStore>(() => FavoritesStore(favoritesBox));
  getIt.registerLazySingleton<ThemeStore>(() => ThemeStore(getIt()));
}
