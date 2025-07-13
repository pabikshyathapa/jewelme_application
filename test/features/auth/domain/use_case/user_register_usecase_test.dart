import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/auth/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/auth/domain/repository/user_repository.dart';
import 'package:jewelme_application/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:mocktail/mocktail.dart';


// Mock class
class MockUserRepository extends Mock implements IuserRepository {}

void main() {
  late MockUserRepository repository;
  late UserRegisterUsecase usecase;

  setUp(() {
    repository = MockUserRepository();
    usecase = UserRegisterUsecase(userRepository: repository);

    // Register fallback for UserEntity used internally in the use case
    registerFallbackValue(UserEntity.empty());
  });

  final params = const RegisterUseParams(
    name: 'Test User',
    email: 'test@email.com',
    phone: '1234567890',
    password: 'securepassword',
  );

  final expectedUserEntity = UserEntity(
    name: params.name,
    email: params.email,
    phone: params.phone,
    password: params.password,
  );

  test('should call registerUser and return Right(null)', () async {
    // Arrange
    when(() => repository.registerUser(any()))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right<Failure, void>(null));
    verify(() => repository.registerUser(expectedUserEntity)).called(1);
  });
}