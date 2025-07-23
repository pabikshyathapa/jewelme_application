// update_cart_quantity_params.dart
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';

class UpdateCartQuantityParams {
  final String userId;
  final String productId;
  final int quantity;

  UpdateCartQuantityParams({
    required this.userId,
    required this.productId,
    required this.quantity,
  });
}
class UpdateCartQuantityUseCase {
  final ICartRepository repository;

  UpdateCartQuantityUseCase(this.repository);

  Future<Either<Failure, void>> call(UpdateCartQuantityParams params) {
    return repository.updateCartItemQuantity(
      userId: params.userId,
      productId: params.productId,
      quantity: params.quantity,
    );
  }
}