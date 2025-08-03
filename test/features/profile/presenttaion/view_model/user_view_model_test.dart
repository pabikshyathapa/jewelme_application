import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/profile/domain/use_case/getuser_usecase.dart';
import 'package:jewelme_application/features/profile/domain/use_case/update_usecase.dart';
import 'package:jewelme_application/features/profile/presenttaion/view_model/user_view_model.dart';
import 'package:mocktail/mocktail.dart';

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

}
