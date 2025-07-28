import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';
import 'package:jewelme_application/features/order/domain/entity/order_item_entity.dart';
import 'package:jewelme_application/features/order/domain/repository/order_repository.dart';
import 'package:jewelme_application/features/order/domain/use_case/get_userby_id_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

// Mock Repository
class MockOrderRepository extends Mock implements IOrderRepository {}

void main() {
  late GetOrdersByUserUsecase usecase;
  late MockOrderRepository mockRepository;

  setUp(() {
    mockRepository = MockOrderRepository();
    usecase = GetOrdersByUserUsecase(orderRepository: mockRepository);
  });

  const userId = 'user123';
  const params = GetOrdersByUserUseParams(userId: userId);

  final orders = [
    OrderEntity(
      id: 'order001',
      userId: userId,
      products: [
        OrderItemEntity(
          productId: 'prod001',
          quantity: 2,
          price: 299.99,
          name: 'Ring',
          filepath: 'ring.jpg',
        )
      ],
      totalAmount: 599.98,
      createdAt: DateTime.parse("2024-08-01T10:30:00.000Z"),
    ),
    OrderEntity(
      id: 'order002',
      userId: userId,
      products: [
        OrderItemEntity(
          productId: 'prod002',
          quantity: 1,
          price: 799.99,
          name: 'Necklace',
          filepath: 'necklace.jpg',
        )
      ],
      totalAmount: 799.99,
      createdAt: DateTime.parse("2024-08-02T15:00:00.000Z"),
    ),
  ];

  test('should return list of orders when repository returns success', () async {
    // Arrange
    when(() => mockRepository.getOrdersByUser(userId))
        .thenAnswer((_) async => Right(orders));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Right(orders));
    verify(() => mockRepository.getOrdersByUser(userId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when repository throws error', () async {
    // Arrange
    final failure = ServerFailure(message: 'Failed to fetch orders');

    when(() => mockRepository.getOrdersByUser(userId))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.getOrdersByUser(userId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
