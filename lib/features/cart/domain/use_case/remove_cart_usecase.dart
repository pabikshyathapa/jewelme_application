// remove_cart_item_params.dart
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';

class RemoveCartItemParams {
  final String userId;
  final String productId;

  RemoveCartItemParams({
    required this.userId,
    required this.productId,
  });
}


class RemoveCartItemUseCase {
  final ICartRepository repository;

  RemoveCartItemUseCase(this.repository);

  Future<Either<Failure, void>> call(RemoveCartItemParams params) {
    return repository.removeCartItem(
      userId: params.userId,
      productId: params.productId,
    );
  }
}