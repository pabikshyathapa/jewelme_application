import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';

abstract interface class IOrderRepository {
  /// Checkout the user's cart and place an order
  Future<Either<Failure, OrderEntity>> checkoutCart(String userId);

  /// Get all orders placed by a specific user
  Future<Either<Failure, List<OrderEntity>>> getOrdersByUser(String userId);
}
