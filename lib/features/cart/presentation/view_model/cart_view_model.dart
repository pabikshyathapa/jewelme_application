import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
import 'package:jewelme_application/features/cart/domain/use_case/addcart_usecase.dart';
import 'package:jewelme_application/features/cart/domain/use_case/fetch_cart_usecase.dart';
import 'package:jewelme_application/features/cart/domain/use_case/remove_cart_usecase.dart';
import 'package:jewelme_application/features/cart/domain/use_case/update_cart_usecase.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_event.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_state.dart';

class CartViewModel extends Bloc<CartEvent, CartState> {
  final AddToCartUsecase _addToCartUsecase;
  final RemoveCartItemUseCase _removeCartItemUsecase;
  final UpdateCartQuantityUseCase _updateCartItemQuantityUsecase;
  final FetchCartUsecase  _fetchCartUseCase;

  CartViewModel({
    required AddToCartUsecase addToCartUsecase,
    required RemoveCartItemUseCase removeCartItemUsecase,
    required UpdateCartQuantityUseCase updateCartItemQuantityUsecase,
    required FetchCartUsecase fetchCartUseCase, // <-- add this

  })  : _addToCartUsecase = addToCartUsecase,
        _removeCartItemUsecase = removeCartItemUsecase,
        _updateCartItemQuantityUsecase = updateCartItemQuantityUsecase,
         _fetchCartUseCase=fetchCartUseCase,
        super(const CartState.initial()) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveCartItemEvent>(_onRemoveCartItem);
    on<UpdateCartItemQuantityEvent>(_onUpdateCartItemQuantity);
    on<FetchCartEvent>(_onFetchCart); 
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _addToCartUsecase(
      AddToCartUseParams(userId: event.userId, product: event.product, quantity: event.quantity),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: 'Failed to add to cart: ${failure.message}',
          color: Colors.red,
        );
      },
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: 'Added to cart!',
        );
      },
    );
  }

  Future<void> _onRemoveCartItem(
    RemoveCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _removeCartItemUsecase(
      RemoveCartItemParams(userId: event.userId, productId: event.productId),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: 'Failed to remove item: ${failure.message}',
          color: Colors.red,
        );
      },
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: 'Item removed from cart!',
        );
      },
    );
  }

  Future<void> _onUpdateCartItemQuantity(
    UpdateCartItemQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _updateCartItemQuantityUsecase(
      UpdateCartQuantityParams(
        userId: event.userId,
        productId: event.productId,
        quantity: event.quantity,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: 'Failed to update quantity: ${failure.message}',
          color: Colors.red,
        );
      },
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: 'Quantity updated!',
        );
      },
    );
  }

  Future<void> _onFetchCart(
  FetchCartEvent event,
  Emitter<CartState> emit,
) async {
  emit(state.copyWith(isLoading: true));
  final result = await _fetchCartUseCase(event.userId);

  result.fold(
    (failure) {
      emit(state.copyWith(isLoading: false, isSuccess: false, errorMessage: failure.message));
      showMySnackBar(
        context: event.context,
        message: 'Failed to load cart: ${failure.message}',
        color: Colors.red,
      );
    },
    (cartItems) {
      emit(state.copyWith(isLoading: false, isSuccess: true, cartItems: cartItems));
    },
  );
}
}
