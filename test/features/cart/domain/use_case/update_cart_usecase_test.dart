import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/cart/domain/use_case/update_cart_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';

// Mock repository
class MockCartRepository extends Mock implements ICartRepository {}

void main() {
  late UpdateCartQuantityUseCase useCase;
  late MockCartRepository mockRepository;

  setUp(() {
    mockRepository = MockCartRepository();
    useCase = UpdateCartQuantityUseCase(mockRepository);
  });

  final params = UpdateCartQuantityParams(
    userId: 'user123',
    productId: 'prod456',
    quantity: 3,
  );

  test('should return Right(null) when updateCartItemQuantity succeeds', () async {
    // Arrange
    when(() => mockRepository.updateCartItemQuantity(
      userId: params.userId,
      productId: params.productId,
      quantity: params.quantity,
    )).thenAnswer((_) async => Right(null));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, Right<Failure, void>(null));
    verify(() => mockRepository.updateCartItemQuantity(
      userId: params.userId,
      productId: params.productId,
      quantity: params.quantity,
    )).called(1);
  });

  test('should return Left(ServerFailure) when updateCartItemQuantity fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Failed to update quantity');

    when(() => mockRepository.updateCartItemQuantity(
      userId: params.userId,
      productId: params.productId,
      quantity: params.quantity,
    )).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, Left<Failure, void>(failure));
    verify(() => mockRepository.updateCartItemQuantity(
      userId: params.userId,
      productId: params.productId,
      quantity: params.quantity,
    )).called(1);
  });
}
