import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/wishlist/domain/repository/wishlist_repository.dart';

class AddToWishlistUseParams extends Equatable {
  final String userId;
  final ProductEntity product;

  const AddToWishlistUseParams({
    required this.userId,
    required this.product,
  });

  @override
  List<Object?> get props => [userId, product];
}

class AddToWishlistUsecase
    implements UsecaseWithParams<void, AddToWishlistUseParams> {
  final IWishlistRepository _wishlistRepository;

  AddToWishlistUsecase({required IWishlistRepository wishlistRepository})
      : _wishlistRepository = wishlistRepository;

  @override
  Future<Either<Failure, void>> call(AddToWishlistUseParams params) {
    return _wishlistRepository.addToWishlist(
      userId: params.userId,
      product: params.product,
    );
  }
}
