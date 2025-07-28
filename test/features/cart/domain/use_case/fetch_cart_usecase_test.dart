import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/cart/domain/use_case/fetch_cart_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_item_entity.dart';
import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';

// Mock repository class
class MockCartRepository extends Mock implements ICartRepository {}

void main() {
  late FetchCartUsecase usecase;
  late MockCartRepository mockRepository;

  setUp(() {
    mockRepository = MockCartRepository();
    usecase = FetchCartUsecase(cartRepository: mockRepository);

    // Register fallback value to avoid errors in mocktail when CartItemEntity is used as argument
    registerFallbackValue(CartItemEntity.empty());
  });

  const userId = 'user123';

  final mockCartItems = [
    const CartItemEntity(
      productId: 'prod1',
      name: 'Gold Ring',
      price: 150.0,
      quantity: 2,
      filepath: 'http://example.com/gold_ring.jpg',
    ),
    const CartItemEntity(
      productId: 'prod2',
      name: 'Silver Necklace',
      price: 200.0,
      quantity: 1,
      filepath: 'http://example.com/silver_necklace.jpg',
    ),
  ];

  test('should return list of CartItemEntity when fetchCart succeeds', () async {
    // Arrange
    when(() => mockRepository.fetchCart(userId))
        .thenAnswer((_) async => Right(mockCartItems));

    // Act
    final result = await usecase(userId);

    // Assert
    expect(result, Right<Failure, List<CartItemEntity>>(mockCartItems));
    verify(() => mockRepository.fetchCart(userId)).called(1);
  });

  test('should return ServerFailure when fetchCart fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Failed to fetch cart');

    when(() => mockRepository.fetchCart(userId))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(userId);

    // Assert
    expect(result, Left<Failure, List<CartItemEntity>>(failure));
    verify(() => mockRepository.fetchCart(userId)).called(1);
  });
}
