import 'package:flutter/widgets.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

@immutable
sealed class CartEvent {}

/// Add product to cart
class AddToCartEvent extends CartEvent {
  final BuildContext context;
  final String userId;
  final ProductEntity product;
  final int quantity;

  AddToCartEvent({
    required this.context,
    required this.userId,
    required this.product,
    required this.quantity,
  });
}

/// Remove product from cart
class RemoveCartItemEvent extends CartEvent {
  final BuildContext context;
  final String userId;
  final String productId;

  RemoveCartItemEvent({
    required this.context,
    required this.userId,
    required this.productId,
  });
}

/// Update product quantity in cart
class UpdateCartItemQuantityEvent extends CartEvent {
  final BuildContext context;
  final String userId;
  final String productId;
  final int quantity;

  UpdateCartItemQuantityEvent({
    required this.context,
    required this.userId,
    required this.productId,
    required this.quantity,
  });
}
class FetchCartEvent extends CartEvent {
  final String userId;
  final BuildContext context;

  FetchCartEvent({
    required this.userId,
    required this.context,
  });
}
class ClearCartEvent extends CartEvent {
  final String userId;
  final BuildContext context;

  ClearCartEvent({required this.userId, required this.context});
}
