import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_product_entity.dart';
import 'package:jewelme_application/features/wishlist/data/data_source/wishlist_data_source.dart';
import 'package:jewelme_application/features/wishlist/domain/repository/wishlist_repository.dart';

class WishlistRemoteRepository implements IWishlistRepository {
  final IWishlistDataSource _wishlistRemoteDataSource;

  WishlistRemoteRepository({
    required IWishlistDataSource wishlistRemoteDataSource,
  }) : _wishlistRemoteDataSource = wishlistRemoteDataSource;

  @override
  Future<Either<Failure, void>> addToWishlist({
    required String userId,
    required ProductEntity product,
  }) async {
    try {
      return await _wishlistRemoteDataSource.addToWishlist(
        userId: userId,
        product: product,
      );
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WishlistEntity>> getWishlistByUser(String userId) async {
    try {
      final wishlist = await _wishlistRemoteDataSource.getWishlistByUser(userId);
      return Right(wishlist);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeWishlistItem({
    required String userId,
    required String productId,
  }) async {
    try {
      await _wishlistRemoteDataSource.removeWishlistItem(
        userId: userId,
        productId: productId,
      );
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WishlistItemEntity>>> fetchWishlistItems(String userId) async {
    try {
      final items = await _wishlistRemoteDataSource.fetchWishlistItems(userId);
      return Right(items);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}
