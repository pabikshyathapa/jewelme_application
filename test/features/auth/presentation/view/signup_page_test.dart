import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/auth/presentation/view/signup_page.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_state.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterBloc extends Mock implements RegisterViewModel {}

class FakeRegisterEvent extends Fake implements RegisterUserEvent {}

class FakeRegisterState extends Fake implements RegisterState {}

void main() {
  late MockRegisterBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeRegisterEvent());
    registerFallbackValue(FakeRegisterState());
  });

  setUp(() {
    mockBloc = MockRegisterBloc();
    when(() => mockBloc.state).thenReturn(const RegisterState.initial());
    when(() => mockBloc.stream).thenAnswer((_) => const Stream<RegisterState>.empty());
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<RegisterViewModel>.value(
        value: mockBloc,
        child: SignUpScreen(),
      ),
    );
  }

 testWidgets('Shows validation errors when form is empty', (tester) async {
  await tester.pumpWidget(createTestWidget());
  await tester.pumpAndSettle();

  final signUpButton = find.widgetWithText(ElevatedButton, 'Sign Up');

  expect(signUpButton, findsOneWidget);

  await tester.ensureVisible(signUpButton);
  await tester.tap(signUpButton);
  await tester.pumpAndSettle();

  
  expect(find.text('Enter Name'), findsOneWidget);
  expect(find.text('Enter Email'), findsOneWidget);
  expect(find.text('Enter Phone Number'), findsOneWidget);
  expect(find.text('Password must be at least 6 characters'), findsOneWidget);
});


  testWidgets('Valid input triggers RegisterUserEvent', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Pabikshya Thapa');
    await tester.enterText(find.byType(TextFormField).at(1), 'pabikshya@example.com');
    await tester.enterText(find.byType(TextFormField).at(2), '9812345678');
    await tester.enterText(find.byType(TextFormField).at(3), 'password123');

    final signUpButton = find.widgetWithText(ElevatedButton, 'Sign Up');
    await tester.ensureVisible(signUpButton);
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    verify(() => mockBloc.add(any(that: isA<RegisterUserEvent>()))).called(1);
  });
}
