import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
import 'package:jewelme_application/features/wishlist/domain/use_case/add_wishlist_usecase.dart';
import 'package:jewelme_application/features/wishlist/domain/use_case/fetch_wishlist_usecase.dart';
import 'package:jewelme_application/features/wishlist/domain/use_case/remove_wishlist_usecase.dart';
import 'package:jewelme_application/features/wishlist/presenttaion/view_model/wishlist_event.dart';
import 'package:jewelme_application/features/wishlist/presenttaion/view_model/wishlist_state.dart';


class WishlistViewModel extends Bloc<WishlistEvent, WishlistState> {
  final AddToWishlistUsecase _addToWishlistUsecase;
  final RemoveWishlistItemUseCase _removeWishlistItemUsecase;
  final FetchWishlistUsecase _fetchWishlistUsecase;

  WishlistViewModel({
    required AddToWishlistUsecase addToWishlistUsecase,
    required RemoveWishlistItemUseCase removeWishlistItemUsecase,
    required FetchWishlistUsecase fetchWishlistUsecase,
  })  : _addToWishlistUsecase = addToWishlistUsecase,
        _removeWishlistItemUsecase = removeWishlistItemUsecase,
        _fetchWishlistUsecase = fetchWishlistUsecase,
        super(const WishlistState.initial()) {
    on<AddToWishlistEvent>(_onAddToWishlist);
    on<RemoveWishlistItemEvent>(_onRemoveWishlistItem);
    on<FetchWishlistEvent>(_onFetchWishlist);
  }

  Future<void> _onAddToWishlist(
    AddToWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _addToWishlistUsecase(
      AddToWishlistUseParams(userId: event.userId, product: event.product),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: 'Failed to add to wishlist: ${failure.message}',
          color: Colors.red,
        );
      },
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: 'Added to wishlist!',
        );
      },
    );
  }

  Future<void> _onRemoveWishlistItem(
    RemoveWishlistItemEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _removeWishlistItemUsecase(
      RemoveWishlistItemParams(userId: event.userId, productId: event.productId),
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
        final updatedWishlist = state.wishlistItems
            ?.where((item) => item.productId != event.productId)
            .toList();
        emit(state.copyWith(isLoading: false, isSuccess: true, wishlistItems: updatedWishlist));
        showMySnackBar(
          context: event.context,
          message: 'Item removed from wishlist!',
        );
      },
    );
  }

  Future<void> _onFetchWishlist(
    FetchWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _fetchWishlistUsecase(event.userId);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false, errorMessage: failure.message));
        showMySnackBar(
          context: event.context,
          message: 'Failed to load wishlist: ${failure.message}',
          color: Colors.red,
        );
      },
      (wishlistItems) {
        emit(state.copyWith(isLoading: false, isSuccess: true, wishlistItems: wishlistItems));
      },
    );
  }
}
