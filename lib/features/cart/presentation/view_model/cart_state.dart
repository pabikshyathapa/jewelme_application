import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_item_entity.dart';

class CartState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final List<CartItemEntity>? cartItems;

  const CartState({
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage,
    this.cartItems,
  });

  const CartState.initial()
      : isLoading = false,
        isSuccess = false,
        errorMessage = null,
        cartItems = const [];

  CartState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    List<CartItemEntity>? cartItems,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage, cartItems];
}
