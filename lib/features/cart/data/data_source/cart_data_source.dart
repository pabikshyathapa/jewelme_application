import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_entity.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_item_entity.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

abstract interface class ICartDataSource {
  /// Add a product to the user's cart
 Future<Either<Failure, void>> addToCart({
    required String userId,
    required ProductEntity product,
    required int quantity,
  });

  /// Fetch the cart for a given user
  Future<CartEntity> getCartByUser(String userId);

  /// Update quantity of a product in the cart
  Future<void> updateCartItemQuantity({
    required String userId,
    required String productId,
    required int quantity,
  });

  /// Remove a product from the cart
  Future<void> removeCartItem({
    required String userId,
    required String productId,
  });

  /// Clear the entire cart for a user
  Future<void> clearCart(String userId);

  /// Get all cart items across all users (admin)
  Future<List<CartEntity>> getAllCartItems();

    Future<List<CartItemEntity>> fetchCart(String userId); // <-- new

}
