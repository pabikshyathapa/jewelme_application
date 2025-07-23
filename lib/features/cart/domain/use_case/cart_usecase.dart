// import 'package:dartz/dartz.dart';
// import 'package:jewelme_application/core/error/failure.dart';
// import 'package:jewelme_application/features/cart/domain/entity/cart_entity.dart';
// import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';

// class CartUseCase {
//   final ICartRepository cartRepository;

//   CartUseCase(this.cartRepository);

//   // Get all cart items for a specific user
//   Future<Either<Failure, List<CartEntity>>> getCartByUser(String userId) {
//     return cartRepository.getCartByUser(userId);
//   }

//   // Add item to cart
//   Future<Either<Failure, void>> addToCart(CartEntity cart, CartProductEntity product) {
//     return cartRepository.addToCart(cart);
//   }

//   // Update a cart item
//   Future<Either<Failure, void>> updateCartItem(CartEntity cart, String productId, int newQuantity) {
//     return cartRepository.updateCartItem(cart);
//   }

//   // Remove a specific product from user's cart
//   Future<Either<Failure, void>> removeCartItem(String productId, String userId) {
//     return cartRepository.removeCartItem(productId, userId);
//   }

//   // Clear the cart for a user
//   Future<Either<Failure, void>> clearCart(String userId) {
//     return cartRepository.clearCart(userId);
//   }

//   // Get all cart items (admin or analytics use case)
//   Future<Either<Failure, List<CartEntity>>> getAllCartItems() {
//     return cartRepository.getAllCartItems();
//   }
// }
