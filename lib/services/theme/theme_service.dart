import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeService {
  Future<bool> loadTheme();
  Future<void> saveTheme(bool isDark);
}

class ThemeServiceImpl implements ThemeService {
  static const _keyTheme = 'isDarkMode';
  final SharedPreferences prefs;

  ThemeServiceImpl(this.prefs);

  @override
  Future<bool> loadTheme() async {
    return prefs.getBool(_keyTheme) ?? false;
  }

  @override
  Future<void> saveTheme(bool isDark) async {
    await prefs.setBool(_keyTheme, isDark);
  }
}
