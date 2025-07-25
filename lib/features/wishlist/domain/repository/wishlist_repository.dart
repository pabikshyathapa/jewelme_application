import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_product_entity.dart';

abstract interface class IWishlistRepository {
  /// Add a product to the user's wishlist
  Future<Either<Failure, void>> addToWishlist({
    required String userId,
    required ProductEntity product,
  });

  /// Get wishlist for a specific user
  Future<Either<Failure, WishlistEntity>> getWishlistByUser(String userId);

  /// Remove a specific item from the wishlist
  Future<Either<Failure, void>> removeWishlistItem({
    required String userId,
    required String productId,
  });

  /// Fetch all wishlist items for a specific user
  Future<Either<Failure, List<WishlistItemEntity>>> fetchWishlistItems(String userId);
}
