import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
import 'package:jewelme_application/features/order/domain/use_case/checkout_usecase.dart';
import 'package:jewelme_application/features/order/domain/use_case/get_userby_id_usecase.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_event.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_state.dart';


class OrderViewModel extends Bloc<OrderEvent, OrderState> {
  final CheckoutCartUsecase _checkoutCartUsecase;
  final GetOrdersByUserUsecase _getOrdersByUserUsecase;

  OrderViewModel({
    required CheckoutCartUsecase checkoutCartUsecase,
    required GetOrdersByUserUsecase getOrdersByUserUsecase,
  })  : _checkoutCartUsecase = checkoutCartUsecase,
        _getOrdersByUserUsecase = getOrdersByUserUsecase,
        super(const OrderState.initial()) {
    on<CheckoutCartEvent>(_onCheckoutCart);
    on<FetchOrdersByUserEvent>(_onFetchOrdersByUser);
  }

  Future<void> _onCheckoutCart(
      CheckoutCartEvent event,
      Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
    final result = await _checkoutCartUsecase(
      CheckoutCartUseParams(userId: event.userId),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false, errorMessage: failure.message));
        showMySnackBar(
          context: event.context,
          message: 'Checkout failed: ${failure.message}',
          color: Colors.red,
        );
      },
      (order) {
        emit(state.copyWith(isLoading: false, isSuccess: true, lastOrder: order));
        showMySnackBar(
          context: event.context,
          message: 'Checkout successful!',
        );
      },
    );
  }

  Future<void> _onFetchOrdersByUser(
      FetchOrdersByUserEvent event,
      Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
    final result = await _getOrdersByUserUsecase(
      GetOrdersByUserUseParams(userId: event.userId),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false, errorMessage: failure.message));
        showMySnackBar(
          context: event.context,
          message: 'Failed to fetch orders: ${failure.message}',
          color: Colors.red,
        );
      },
      (orders) {
        emit(state.copyWith(isLoading: false, isSuccess: true, orders: orders));
      },
    );
  }
}
