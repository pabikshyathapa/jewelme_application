import 'package:flutter/widgets.dart';

@immutable
sealed class OrderEvent {}
class CheckoutCartEvent extends OrderEvent {
  final BuildContext context;
  final String userId;

  CheckoutCartEvent({
    required this.context,
    required this.userId,
  });
}
// class CheckoutCartEvent extends OrderEvent {
//   final BuildContext context;
//   final String userId;
//   final List<CartItemEntity> products;
//   final double totalAmount;

//   CheckoutCartEvent({
//     required this.context,
//     required this.userId,
//     required this.products,
//     required this.totalAmount,
//   });
// }
/// Fetch all orders placed by a specific user
class FetchOrdersByUserEvent extends OrderEvent {
  final BuildContext context;
  final String userId;

  FetchOrdersByUserEvent({
    required this.context,
    required this.userId,
  });
}
