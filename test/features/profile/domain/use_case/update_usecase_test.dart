import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/profile/domain/repository/user_repository.dart';
import 'package:jewelme_application/features/profile/domain/use_case/update_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

// Mock repository
class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  late UpdateUserProfileUsecase usecase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = UpdateUserProfileUsecase(userRepository: mockRepository);
  });

  const userId = 'user123';

  final updatedUser = UserEntity(
    id: userId,
    name: 'Updated User',
    email: 'updated@example.com',
    phone: '9876543210',
    // add other fields as required
  );

  final params = UpdateUserProfileUseParams(
    userId: userId,
    updatedUser: updatedUser,
  );

  test('should return updated UserEntity when update is successful', () async {
    // Arrange
    when(() => mockRepository.updateUserProfile(userId, updatedUser))
        .thenAnswer((_) async => Right(updatedUser));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Right(updatedUser));
    verify(() => mockRepository.updateUserProfile(userId, updatedUser)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when update fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Update failed');

    when(() => mockRepository.updateUserProfile(userId, updatedUser))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.updateUserProfile(userId, updatedUser)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
