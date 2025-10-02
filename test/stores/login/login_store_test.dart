import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:salsa_challenge/stores/login/login_store.dart';
import 'package:salsa_challenge/services/login/login_service.dart';

class MockLoginService extends Mock implements LoginService {}

void main() {
  late MockLoginService mockService;
  late LoginStore store;

  setUp(() {
    mockService = MockLoginService();
    store = LoginStore(mockService);
  });

  group('LoginStore', () {
    test('loadLoginStatus atualiza isLoggedIn', () async {
      when(() => mockService.loadLoginStatus())
          .thenAnswer((_) async => true);

      await store.loadLoginStatus();

      expect(store.isLoggedIn, isTrue);
      verify(() => mockService.loadLoginStatus()).called(1);
    });

    test('login válido seta isLoggedIn=true e limpa errorMessage', () async {
      when(() => mockService.login('salsa', 'salsa'))
          .thenAnswer((_) async => true);

      final result = await store.login('salsa', 'salsa');

      expect(result, isTrue);
      expect(store.isLoggedIn, isTrue);
      expect(store.errorMessage, isNull);
      verify(() => mockService.login('salsa', 'salsa')).called(1);
    });

    test('login inválido popula errorMessage e isLoggedIn continua false', () async {
      when(() => mockService.login('wrong', 'user'))
          .thenAnswer((_) async => false);

      final result = await store.login('wrong', 'user');

      expect(result, isFalse);
      expect(store.isLoggedIn, isFalse);
      expect(store.errorMessage, 'Usuário ou senha inválidos');
      verify(() => mockService.login('wrong', 'user')).called(1);
    });

    test('logout seta isLoggedIn=false', () async {
      store.isLoggedIn = true;
      when(() => mockService.logout())
          .thenAnswer((_) async {});

      await store.logout();

      expect(store.isLoggedIn, isFalse);
      verify(() => mockService.logout()).called(1);
    });
  });
}
