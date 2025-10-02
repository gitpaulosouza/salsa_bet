import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:salsa_challenge/services/theme/theme_service.dart';
import 'package:salsa_challenge/stores/theme/theme_store.dart';

class MockThemeService extends Mock implements ThemeService {}

void main() {
  late MockThemeService mockService;

  setUp(() {
    mockService = MockThemeService();
  });

  group('ThemeStore', () {
    test('deve iniciar carregando o valor do ThemeService', () async {
      when(() => mockService.loadTheme()).thenAnswer((_) async => true);

      final store = ThemeStore(mockService);
      await Future.delayed(Duration.zero);
      expect(store.isDarkMode, true);
    });

    test('toggleTheme deve inverter e salvar no ThemeService', () async {
      when(() => mockService.loadTheme()).thenAnswer((_) async => false);
      when(() => mockService.saveTheme(any())).thenAnswer((_) async {});

      final store = ThemeStore(mockService);
      await Future.delayed(Duration.zero);

      final initial = store.isDarkMode;

      await store.toggleTheme();

      expect(store.isDarkMode, !initial);
      verify(() => mockService.saveTheme(!initial)).called(1);
    });
  });
}
