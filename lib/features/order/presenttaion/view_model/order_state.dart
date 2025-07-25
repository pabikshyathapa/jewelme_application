import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';

class OrderState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final List<OrderEntity>? orders;
  final OrderEntity? lastOrder; // for checkout result

  const OrderState({
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage,
    this.orders,
    this.lastOrder,
  });

  const OrderState.initial()
      : isLoading = false,
        isSuccess = false,
        errorMessage = null,
        orders = const [],
        lastOrder = null;

 OrderState copyWith({
  bool? isLoading,
  bool? isSuccess,
  String? errorMessage,
  bool clearErrorMessage = false,
  List<OrderEntity>? orders,
  OrderEntity? lastOrder,
}) {
  return OrderState(
    isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    orders: orders ?? this.orders,
    lastOrder: lastOrder ?? this.lastOrder,
  );
}

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage, orders, lastOrder];
}
