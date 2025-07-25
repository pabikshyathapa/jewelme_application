import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_product_entity.dart';

class WishlistState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final List<WishlistItemEntity>? wishlistItems;

  const WishlistState({
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage,
    this.wishlistItems,
  });

  const WishlistState.initial()
      : isLoading = false,
        isSuccess = false,
        errorMessage = null,
        wishlistItems = const [];

  WishlistState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    List<WishlistItemEntity>? wishlistItems,
  }) {
    return WishlistState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      wishlistItems: wishlistItems ?? this.wishlistItems,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage, wishlistItems];
}
