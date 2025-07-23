import 'package:dartz/dartz.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_item_entity.dart';
import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';


class FetchCartUsecase implements UsecaseWithParams<List<CartItemEntity>, String> {
  final ICartRepository _cartRepository;

  FetchCartUsecase({required ICartRepository cartRepository})
      : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, List<CartItemEntity>>> call(String userId) {
    return _cartRepository.fetchCart(userId);
  }
}
