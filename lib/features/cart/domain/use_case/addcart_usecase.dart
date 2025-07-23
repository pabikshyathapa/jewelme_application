import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

class AddToCartUseParams extends Equatable {
  final String userId;
  final ProductEntity product;
  final int quantity;
  

  const AddToCartUseParams({
    required this.userId,
    required this.product,
    required this.quantity
  });

  @override
  List<Object?> get props => [userId, product];
}

class AddToCartUsecase implements UsecaseWithParams<void, AddToCartUseParams> {
  final ICartRepository _cartRepository;

  AddToCartUsecase({required ICartRepository cartRepository})
      : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, void>> call(AddToCartUseParams params) {
    return _cartRepository.addToCart(userId: params.userId, product: params.product, quantity: params.quantity);
  }
}