import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/wishlist/domain/repository/wishlist_repository.dart';

class RemoveWishlistItemParams {
  final String userId;
  final String productId;

  RemoveWishlistItemParams({
    required this.userId,
    required this.productId,
  });
}

class RemoveWishlistItemUseCase {
  final IWishlistRepository repository;

  RemoveWishlistItemUseCase(this.repository);

  Future<Either<Failure, void>> call(RemoveWishlistItemParams params) {
    return repository.removeWishlistItem(
      userId: params.userId,
      productId: params.productId,
    );
  }
}
