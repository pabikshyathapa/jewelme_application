import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/cart/domain/use_case/remove_cart_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';

// Mock repository
class MockCartRepository extends Mock implements ICartRepository {}

void main() {
  late RemoveCartItemUseCase useCase;
  late MockCartRepository mockRepository;

  setUp(() {
    mockRepository = MockCartRepository();
    useCase = RemoveCartItemUseCase(mockRepository);
  });

  final params = RemoveCartItemParams(
    userId: 'user123',
    productId: 'prod456',
  );

  test('should return Right(null) when removeCartItem succeeds', () async {
    // Arrange
    when(() => mockRepository.removeCartItem(
      userId: params.userId,
      productId: params.productId,
    )).thenAnswer((_) async => Right(null));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, Right<Failure, void>(null));
    verify(() => mockRepository.removeCartItem(
      userId: params.userId,
      productId: params.productId,
    )).called(1);
  });

  test('should return Left(ServerFailure) when removeCartItem fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Failed to remove item');

    when(() => mockRepository.removeCartItem(
      userId: params.userId,
      productId: params.productId,
    )).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, Left<Failure, void>(failure));
    verify(() => mockRepository.removeCartItem(
      userId: params.userId,
      productId: params.productId,
    )).called(1);
  });
}
