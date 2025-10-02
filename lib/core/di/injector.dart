import 'package:get_it/get_it.dart';
import 'package:salsa_challenge/services/login/login_service.dart';
import 'package:salsa_challenge/stores/login/login_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<LoginService>(() => LoginServiceImpl(prefs));

  getIt.registerFactory<LoginStore>(() => LoginStore(getIt<LoginService>()));
}
