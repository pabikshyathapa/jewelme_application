// // get_cart_by_user_usecase.dart
// import 'package:dartz/dartz.dart';
// import 'package:jewelme_application/core/error/failure.dart';
// import 'package:jewelme_application/features/cart/domain/entity/cart_entity.dart';
// import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';

// class GetCartByUserUseCase {
//   final ICartRepository repository;

//   GetCartByUserUseCase(this.repository);

//   Future<Either<Failure, CartEntity>> call(String userId) {
//     return repository.getCartByUser(userId);
//   }
// }
