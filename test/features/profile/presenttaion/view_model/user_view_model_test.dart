import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/profile/domain/use_case/getuser_usecase.dart';
import 'package:jewelme_application/features/profile/domain/use_case/update_usecase.dart';
import 'package:jewelme_application/features/profile/presenttaion/view_model/user_event.dart';
import 'package:jewelme_application/features/profile/presenttaion/view_model/user_view_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

// ─── Mock Usecases ─────────────────────────────────────────────
class MockGetUserProfileUsecase extends Mock implements GetUserProfileUsecase {}
class MockUpdateUserProfileUsecase extends Mock implements UpdateUserProfileUsecase {}

// ─── Fakes for Parameters ──────────────────────────────────────
class FakeBuildContext extends Fake implements BuildContext {}

class FakeUpdateParams extends Fake implements UpdateUserProfileUseParams {}
class FakeGetParams extends Fake implements GetUserProfileUseParams {}

void main() {
  late MockGetUserProfileUsecase mockGetUserUsecase;
  late MockUpdateUserProfileUsecase mockUpdateUserUsecase;
  late UserViewModel userViewModel;
  late BuildContext fakeContext;

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
    registerFallbackValue(FakeUpdateParams());
    registerFallbackValue(FakeGetParams());
  });

  setUp(() {
    mockGetUserUsecase = MockGetUserProfileUsecase();
    mockUpdateUserUsecase = MockUpdateUserProfileUsecase();
    userViewModel = UserViewModel(
      getUserProfileUsecase: mockGetUserUsecase,
      updateUserProfileUsecase: mockUpdateUserUsecase,
    );
    fakeContext = FakeBuildContext();
  });

  final testUser = UserEntity(
    id: 'user1',
    name: 'John Doe',
    email: 'john@example.com',
    phone: '9800000000',
    filepath: 'https://example.com/image.jpg',
    // add other required fields if any
  );

  group('UserViewModel Tests', () {
    testWidgets('emits loading and success, shows snackbar on successful profile fetch', (tester) async {
      when(() => mockGetUserUsecase.call(any())).thenAnswer((_) async => Right(testUser));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: userViewModel,
              child: Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<UserViewModel>().add(GetUserProfileEvent(
                      userId: testUser.id,
                      context: context,
                    ));
                  },
                  child: const Text('Fetch Profile'),
                );
              }),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Fetch Profile'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(SnackBar), findsNothing);
      expect(userViewModel.state.user, testUser);
      expect(userViewModel.state.isSuccess, true);
      expect(userViewModel.state.isLoading, false);
    });

    testWidgets('emits loading and failure, shows snackbar on failed profile fetch', (tester) async {
      when(() => mockGetUserUsecase.call(any())).thenAnswer(
        (_) async => Left(ServerFailure(message: 'Failed to fetch profile')),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: userViewModel,
              child: Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<UserViewModel>().add(GetUserProfileEvent(
                      userId: testUser.id,
                      context: context,
                    ));
                  },
                  child: const Text('Fetch Profile'),
                );
              }),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Fetch Profile'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.textContaining('Failed to fetch profile'), findsOneWidget);
      expect(userViewModel.state.errorMessage, isNotNull);
      expect(userViewModel.state.isSuccess, false);
      expect(userViewModel.state.isLoading, false);
    });

    testWidgets('emits loading and success, shows snackbar on successful profile update', (tester) async {
      when(() => mockUpdateUserUsecase.call(any())).thenAnswer((_) async => Right(testUser));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: userViewModel,
              child: Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<UserViewModel>().add(UpdateUserProfileEvent(
                      userId: testUser.id,
                      updatedUser: testUser,
                      context: context,
                    ));
                  },
                  child: const Text('Update Profile'),
                );
              }),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Update Profile'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.textContaining('Profile updated successfully'), findsOneWidget);
      expect(userViewModel.state.user, testUser);
      expect(userViewModel.state.isSuccess, true);
      expect(userViewModel.state.isLoading, false);
    });

    testWidgets('emits loading and failure, shows snackbar on failed profile update', (tester) async {
      when(() => mockUpdateUserUsecase.call(any())).thenAnswer(
        (_) async => Left(ServerFailure(message: 'Failed to update profile')),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: userViewModel,
              child: Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<UserViewModel>().add(UpdateUserProfileEvent(
                      userId: testUser.id,
                      updatedUser: testUser,
                      context: context,
                    ));
                  },
                  child: const Text('Update Profile'),
                );
              }),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Update Profile'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.textContaining('Failed to update profile'), findsOneWidget);
      expect(userViewModel.state.errorMessage, isNotNull);
      expect(userViewModel.state.isSuccess, false);
      expect(userViewModel.state.isLoading, false);
    });
  });
}
