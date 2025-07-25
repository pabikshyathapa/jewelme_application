import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_product_entity.dart';

abstract interface class IWishlistDataSource {
  /// Add a product to the user's wishlist
  Future<Either<Failure, void>> addToWishlist({
    required String userId,
    required ProductEntity product,
  });

  /// Fetch the wishlist for a given user
  Future<WishlistEntity> getWishlistByUser(String userId);

  /// Remove a product from the wishlist
  Future<void> removeWishlistItem({
    required String userId,
    required String productId,
  });

  /// Fetch all wishlist items for a user
  Future<List<WishlistItemEntity>> fetchWishlistItems(String userId); // <-- optional helper
}
