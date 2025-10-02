import 'package:mobx/mobx.dart';
import 'package:salsa_challenge/services/login/login_service.dart';

part 'login_store.g.dart';

// ignore: invalid_use_of_private_type_in_public_api
class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final LoginService _service;

  _LoginStore(this._service);

  @observable
  bool isLoggedIn = false;

  @observable
  String? errorMessage;

  @action
  Future<void> loadLoginStatus() async {
    isLoggedIn = await _service.loadLoginStatus();
  }

  @action
  Future<bool> login(String username, String password) async {
    final success = await _service.login(username, password);
    if (success) {
      isLoggedIn = true;
      errorMessage = null;
    } else {
      errorMessage = 'Usuário ou senha inválidos';
    }
    return success;
  }

  @action
  Future<void> logout() async {
    await _service.logout();
    isLoggedIn = false;
  }
}
