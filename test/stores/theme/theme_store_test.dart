import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:salsa_challenge/stores/theme/theme_store.dart';
import 'package:salsa_challenge/services/theme/theme_service.dart';

class MockThemeService extends Mock implements ThemeService {}

void main() {
  late MockThemeService mockService;
  late ThemeStore store;

  setUp(() {
    mockService = MockThemeService();
  });

  group('ThemeStore', () {
    test('carrega tema inicial do service', () async {
      when(() => mockService.loadTheme()).thenAnswer((_) async => true);

      store = ThemeStore(mockService);
      await Future.delayed(Duration.zero);

      expect(store.isDarkMode, isTrue);
      verify(() => mockService.loadTheme()).called(1);
    });

    test('toggleTheme inverte valor e salva no service', () async {
      when(() => mockService.loadTheme()).thenAnswer((_) async => false);
      when(() => mockService.saveTheme(any())).thenAnswer((_) async {});

      store = ThemeStore(mockService);
      await Future.delayed(Duration.zero);

      await store.toggleTheme();

      expect(store.isDarkMode, isTrue);
      verify(() => mockService.saveTheme(true)).called(1);
    });
  });
}
