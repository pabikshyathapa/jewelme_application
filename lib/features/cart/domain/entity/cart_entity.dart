import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_item_entity.dart';

class CartEntity extends Equatable {
  final String? cartId;
  final String userId;
  final List<CartItemEntity> products;

  const CartEntity({
    this.cartId,
    required this.userId,
    required this.products,
  });

  @override
  List<Object?> get props => [
        cartId,
        userId,
        products,
      ];

  factory CartEntity.empty() {
    return const CartEntity(
      cartId: null,
      userId: '',
      products: [],
    );
  }
}
