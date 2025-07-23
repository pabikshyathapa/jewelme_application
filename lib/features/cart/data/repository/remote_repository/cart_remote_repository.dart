import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/cart/data/data_source/cart_data_source.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_entity.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_item_entity.dart';
import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

class CartRemoteRepository implements ICartRepository {
  final ICartDataSource _cartRemoteDatasource;

  CartRemoteRepository({
    required ICartDataSource cartRemoteDatasource,
  }) : _cartRemoteDatasource = cartRemoteDatasource;
  @override
  Future<Either<Failure, void>> addToCart({
  required String userId,
  required ProductEntity product,
  required int quantity,
}) async {
  try {
    await _cartRemoteDatasource.addToCart(
      userId: userId,
      product: product,
      quantity: quantity,
    );
    return const Right(null);
  } catch (e) {
    return Left(RemoteDatabaseFailure(message: e.toString()));
  }
}

  @override
  Future<Either<Failure, CartEntity>> getCartByUser(String userId) async {
    try {
      final cart = await _cartRemoteDatasource.getCartByUser(userId);
      return Right(cart);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCartItemQuantity({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    try {
      await _cartRemoteDatasource.updateCartItemQuantity(
        userId: userId,
        productId: productId,
        quantity: quantity,
      );
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeCartItem({
    required String userId,
    required String productId,
  }) async {
    try {
      await _cartRemoteDatasource.removeCartItem(
        userId: userId,
        productId: productId,
      );
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart(String userId) async {
    try {
      await _cartRemoteDatasource.clearCart(userId);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getAllCartItems() async {
    try {
      final items = await _cartRemoteDatasource.getAllCartItems();
      return Right(items);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItemEntity>>> fetchCart(String userId) async {
  try {
    final List<CartItemEntity> cartItems = await _cartRemoteDatasource.fetchCart(userId);
    return Right(cartItems);
  } catch (e) {
    return Left(RemoteDatabaseFailure(message: e.toString()));
  }
}
}
