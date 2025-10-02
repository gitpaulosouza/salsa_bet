import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salsa_challenge/services/login/login_service.dart';

void main() {
  late SharedPreferences prefs;
  late LoginService service;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    service = LoginServiceImpl(prefs);
  });

  test('Login com credenciais válidas retorna true', () async {
    final result = await service.login('salsa', 'salsa');
    expect(result, isTrue);
    expect(await service.loadLoginStatus(), isTrue);
  });

  test('Login com credenciais inválidas retorna false', () async {
    final result = await service.login('user', 'wrong');
    expect(result, isFalse);
    expect(await service.loadLoginStatus(), isFalse);
  });

  test('Logout desloga o usuário', () async {
    await service.login('salsa', 'salsa');
    expect(await service.loadLoginStatus(), isTrue);

    await service.logout();
    expect(await service.loadLoginStatus(), isFalse);
  });

  test('loadLoginStatus reflete valor armazenado', () async {
    await service.login('salsa', 'salsa');
    final status = await service.loadLoginStatus();
    expect(status, isTrue);
  });
}
