import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/order/domain/use_case/checkout_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';
import 'package:jewelme_application/features/order/domain/entity/order_item_entity.dart';
import 'package:jewelme_application/features/order/domain/repository/order_repository.dart';

// Mock Repository
class MockOrderRepository extends Mock implements IOrderRepository {}

void main() {
  late CheckoutCartUsecase usecase;
  late MockOrderRepository mockRepository;

  setUp(() {
    mockRepository = MockOrderRepository();
    usecase = CheckoutCartUsecase(orderRepository: mockRepository);
  });

  const userId = 'user123';
  const params = CheckoutCartUseParams(userId: userId);

  final order = OrderEntity(
    id: 'order001',
    userId: userId,
    products: [
      OrderItemEntity(
        productId: 'prod001',
        quantity: 2,
        price: 299.99,
         name: '', 
         filepath: '',
      ),
      OrderItemEntity(
        productId: 'prod002',
        quantity: 1,
        price: 499.99, 
        name: '', 
        filepath: '',
      ),
    ],
    totalAmount: 1099.97,
    createdAt: DateTime.parse("2024-08-01T10:30:00.000Z"),
  );

  test('should return OrderEntity when checkout is successful', () async {
    // Arrange
    when(() => mockRepository.checkoutCart(userId))
        .thenAnswer((_) async => Right(order));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Right(order));
    verify(() => mockRepository.checkoutCart(userId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when checkout fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Checkout failed');

    when(() => mockRepository.checkoutCart(userId))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.checkoutCart(userId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
