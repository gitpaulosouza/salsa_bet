import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginService {
  Future<bool> login(String username, String password);
  Future<void> logout();
  Future<bool> loadLoginStatus();
}

class LoginServiceImpl implements LoginService {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  final SharedPreferences prefs;

  LoginServiceImpl(this.prefs);

  @override
  Future<bool> login(String username, String password) async {
    if (username == 'salsa' && password == 'salsa') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, true);
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  @override
  Future<bool> loadLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }
}
