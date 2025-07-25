import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';
import 'package:jewelme_application/features/order/domain/repository/order_repository.dart';

class CheckoutCartUseParams extends Equatable {
  final String userId;

  const CheckoutCartUseParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
class CheckoutCartUsecase implements UsecaseWithParams<OrderEntity, CheckoutCartUseParams> {
  final IOrderRepository _orderRepository;

  CheckoutCartUsecase({required IOrderRepository orderRepository})
      : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, OrderEntity>> call(CheckoutCartUseParams params) {
    return _orderRepository.checkoutCart(params.userId);
  }
}