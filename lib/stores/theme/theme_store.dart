import 'package:mobx/mobx.dart';
import 'package:salsa_challenge/services/theme/theme_service.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  final ThemeService _service;

  _ThemeStore(this._service) {
    _init();
  }

  @observable
  bool isDarkMode = false;

  @action
  Future<void> _init() async {
    isDarkMode = await _service.loadTheme();
  }

  @action
  Future<void> toggleTheme() async {
    isDarkMode = !isDarkMode;
    await _service.saveTheme(isDarkMode);
  }
}
