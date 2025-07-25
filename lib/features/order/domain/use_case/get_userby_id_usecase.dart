import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';
import 'package:jewelme_application/features/order/domain/repository/order_repository.dart';

class GetOrdersByUserUseParams extends Equatable {
  final String userId;

  const GetOrdersByUserUseParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class GetOrdersByUserUsecase implements UsecaseWithParams<List<OrderEntity>, GetOrdersByUserUseParams> {
  final IOrderRepository _orderRepository;

  GetOrdersByUserUsecase({required IOrderRepository orderRepository})
      : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, List<OrderEntity>>> call(GetOrdersByUserUseParams params) {
    return _orderRepository.getOrdersByUser(params.userId);
  }
}