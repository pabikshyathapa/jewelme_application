import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/order/data/data_source/order_datasource.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';
import 'package:jewelme_application/features/order/domain/repository/order_repository.dart';

class OrderRemoteRepository implements IOrderRepository {
  final IOrderDataSource _orderRemoteDataSource;

  OrderRemoteRepository({
    required IOrderDataSource orderRemoteDataSource,
  }) : _orderRemoteDataSource = orderRemoteDataSource;

  @override
  Future<Either<Failure, OrderEntity>> checkoutCart(String userId) async {
    try {
      final result = await _orderRemoteDataSource.checkoutCart(userId);
      return result;
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrdersByUser(String userId) async {
    try {
      final result = await _orderRemoteDataSource.getOrdersByUser(userId);
      return result;
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}
