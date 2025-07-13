import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';


class FakeLoginUsecaseParams extends Fake implements LoginParams {}

class MockUserLoginUsecase extends Mock implements UserLoginUsecase {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late MockUserLoginUsecase mockUserLoginUsecase;

  setUpAll(() {
    registerFallbackValue(FakeLoginUsecaseParams());
    registerFallbackValue(FakeBuildContext());
  });

  setUp(() {
    mockUserLoginUsecase = MockUserLoginUsecase();
  });

  void main() {
  // Your mock setup and variables here
  late MockUserLoginUsecase mockLoginUsecase;
  late LoginViewModel loginViewModel;

  const testEmail = 'test@example.com';
  const testPassword = 'password123';
  const testToken = 'fake_token';

  setUp(() {
    mockLoginUsecase = MockUserLoginUsecase();
    loginViewModel = LoginViewModel(mockLoginUsecase);
  });

  group('LoginViewModel with snackbar and context', () {
    testWidgets('LoginViewModel emits loading and success and shows snackbar', (tester) async {
      // Mock your usecase to succeed
      when(() => mockLoginUsecase.call(any()))
          .thenAnswer((_) async => const Right(testToken));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Container(key: const Key('login_container'));
              },
            ),
          ),
        ),
      );

      final context = tester.element(find.byKey(const Key('login_container')));

      loginViewModel.add(LoginWithEmailAndPasswordEvent(
        email: testEmail,
        password: testPassword,
        context: context,
      ));

      await tester.pumpAndSettle();

      // Assert 
      expect(loginViewModel.state.isLoading, false);
      expect(loginViewModel.state.isSuccess, true);

      
      verify(() => mockLoginUsecase.call(
        LoginParams(email: testEmail, password: testPassword),
      )).called(1);
    });
  }); 
}

}