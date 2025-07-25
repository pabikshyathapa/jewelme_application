import 'package:dartz/dartz.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_product_entity.dart';
import 'package:jewelme_application/features/wishlist/domain/repository/wishlist_repository.dart';

class FetchWishlistUsecase
    implements UsecaseWithParams<List<WishlistItemEntity>, String> {
  final IWishlistRepository _wishlistRepository;

  FetchWishlistUsecase({required IWishlistRepository wishlistRepository})
      : _wishlistRepository = wishlistRepository;

  @override
  Future<Either<Failure, List<WishlistItemEntity>>> call(String userId) {
    return _wishlistRepository.fetchWishlistItems(userId);
  }
}
