import 'package:get_it/get_it.dart';
import 'package:salsa_challenge/services/login/login_service.dart';
import 'package:salsa_challenge/stores/login/login_store.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {

  getIt.registerLazySingleton<LoginService>(() => LoginServiceImpl());

  getIt.registerFactory<LoginStore>(() => LoginStore(getIt<LoginService>()));
}
