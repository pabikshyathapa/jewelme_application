import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/profile/domain/repository/user_repository.dart';
import 'package:jewelme_application/features/profile/domain/use_case/getuser_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

// Mock Repository
class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  late GetUserProfileUsecase usecase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = GetUserProfileUsecase(userRepository: mockRepository);
  });

  const userId = 'user123';
  const params = GetUserProfileUseParams(userId: userId);

  final userEntity = UserEntity(
    id: 'user123',
    name: 'Test User',
    email: 'test@example.com',
    phone: '1234567890',
    // Add other fields as needed based on your UserEntity constructor
  );

  test('should return UserEntity when repository returns success', () async {
    // Arrange
    when(() => mockRepository.getUserProfile(userId))
        .thenAnswer((_) async => Right(userEntity));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Right(userEntity));
    verify(() => mockRepository.getUserProfile(userId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when repository fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Failed to fetch user profile');

    when(() => mockRepository.getUserProfile(userId))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.getUserProfile(userId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
