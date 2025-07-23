import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_entity.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_item_entity.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

abstract interface class ICartRepository {

 Future<Either<Failure, void>> addToCart({
    required String userId,
    required ProductEntity product,
    required int quantity,
  });

  Future<Either<Failure, CartEntity>> getCartByUser(String userId);

  Future<Either<Failure, void>> updateCartItemQuantity({
    required String userId,
    required String productId,
    required int quantity,
  });

  Future<Either<Failure, void>> removeCartItem({
    required String userId,
    required String productId,
  });

  Future<Either<Failure, void>> clearCart(String userId);
  
  Future<Either<Failure, List<CartItemEntity>>> fetchCart(String userId);


  Future<Either<Failure, List<CartEntity>>> getAllCartItems();
}
