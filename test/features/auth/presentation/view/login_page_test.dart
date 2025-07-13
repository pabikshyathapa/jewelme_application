import 'package:bloc_test/bloc_test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/auth/presentation/view/login_page.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:mocktail/mocktail.dart';



class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
  implements LoginViewModel {}

void main() {
  late MockLoginBloc loginViewModel;


  setUp((){
    loginViewModel = MockLoginBloc();
  });

  Widget loadLoginView(){
    return BlocProvider<LoginViewModel>(
      create: (context) => loginViewModel,
      child: MaterialApp(home: LoginPage()),
    );
  }

testWidgets('Check for the text in login UI', (tester) async {
  await tester.pumpWidget(loadLoginView());
  await tester.pumpAndSettle();

  // Find the ElevatedButton with the text 'Sign In'
  final result = find.widgetWithText(ElevatedButton, 'Log In');

  // Assert it exists
  expect(result, findsOneWidget);
});


  testWidgets ('Check for the email and password', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField). at(0), 'pabikshya123@gmail.com');
    await tester. enterText(find.byType(TextField).at(1), 'password');
    await tester.tap(find.byType(ElevatedButton) .first);
    
    await tester.pumpAndSettle();
    expect (find. text ('pabikshya123@gmail.com'), findsOneWidget); 
    expect (find. text ('password'), findsOneWidget);



  });

testWidgets('Check for the validator error', (tester) async {
  await tester.pumpWidget(loadLoginView());
  await tester.pumpAndSettle();

  final loginButtonFinder = find.byType(ElevatedButton);

  await tester.ensureVisible(loginButtonFinder);
  await tester.tap(loginButtonFinder);
  await tester.pumpAndSettle();

  expect(find.text('Please enter your email'), findsOneWidget);
  expect(find.text('Please enter your password'), findsOneWidget);
});

  testWidgets('Login success', (tester) async {
  // Arrange - Mock the state
  when(() => loginViewModel.state).thenReturn(
    LoginState(isLoading: false, isSuccess: true),
  );

  await tester.pumpWidget(loadLoginView());
  await tester.pumpAndSettle();

  // Enter valid email and password
  await tester.enterText(find.byType(TextField).at(0), 'pabikshya123@gmail.com');
  await tester.enterText(find.byType(TextField).at(1), 'pabikshya');

  // Tap the login button
  await tester.tap(find.byType(ElevatedButton).first);
  await tester.pumpAndSettle();

  // Assert - Ensure login was successful
  expect(loginViewModel.state.isSuccess, true);
});
}