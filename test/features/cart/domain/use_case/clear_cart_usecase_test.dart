import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/cart/domain/use_case/clear_cart_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';

// Create mock class
class MockCartRepository extends Mock implements ICartRepository {}

void main() {
  late ClearCartUsecase usecase;
  late MockCartRepository repository;

  setUp(() {
    repository = MockCartRepository();
    usecase = ClearCartUsecase(cartRepository: repository);
  });

  const userId = 'user123';

  test('should return Right(null) when clearCart succeeds', () async {
    // Arrange
    when(() => repository.clearCart(userId))
        .thenAnswer((_) async => Right(null));

    // Act
    final result = await usecase(userId);

    // Assert
    expect(result, Right<Failure, void>(null));
    verify(() => repository.clearCart(userId)).called(1);
  });

  test('should return Left(ServerFailure) when clearCart fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Failed to clear cart');

    when(() => repository.clearCart(userId))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(userId);

    // Assert
    expect(result, Left<Failure, void>(failure));
    verify(() => repository.clearCart(userId)).called(1);
  });
}
