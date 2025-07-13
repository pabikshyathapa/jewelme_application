import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterUseCase extends Mock implements UserRegisterUsecase {}

class FakeRegisterUserParams extends Fake implements RegisterUseParams {}

void main() {
  late MockRegisterUseCase mockUseCase;

  setUpAll(() {
    registerFallbackValue(FakeRegisterUserParams());
  });

  setUp(() {
    mockUseCase = MockRegisterUseCase();
  });

  testWidgets('RegisterViewModel emits loading and success and shows snackbar', (tester) async {
    when(() => mockUseCase.call(any()))
        .thenAnswer((_) async => const Right(true));

    final viewModel = RegisterViewModel(registerUsecase: mockUseCase);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: viewModel,
            child: Builder(
              builder: (context) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<RegisterViewModel>().add(
                            RegisterUserEvent(
                              name: 'John',
                              email: 'john@example.com',
                              phone: '9800000000',
                              password: 'secret123',
                              context: context,
                            ),
                          );
                    },
                    child: const Text('Register'),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Register'));
    await tester.pump(); // let bloc emit loading
    await tester.pump(const Duration(seconds: 1)); // allow snackbar to appear

    // Assertion
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(' Registered successful!'), findsOneWidget);
  });
}