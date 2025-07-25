import 'package:flutter/widgets.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

@immutable
sealed class WishlistEvent {}

/// Add product to wishlist
class AddToWishlistEvent extends WishlistEvent {
  final BuildContext context;
  final String userId;
  final ProductEntity product;

  AddToWishlistEvent({
    required this.context,
    required this.userId,
    required this.product,
  });
}

/// Remove product from wishlist
class RemoveWishlistItemEvent extends WishlistEvent {
  final BuildContext context;
  final String userId;
  final String productId;

  RemoveWishlistItemEvent({
    required this.context,
    required this.userId,
    required this.productId,
  });
}

/// Fetch wishlist items for user
class FetchWishlistEvent extends WishlistEvent {
  final BuildContext context;
  final String userId;

  FetchWishlistEvent({
    required this.context,
    required this.userId,
  });
}
