
import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_product_entity.dart';

class WishlistEntity extends Equatable {
  final String? wishlistId; // optional, if you use _id in MongoDB
  final String userId;
  final List<WishlistItemEntity> products;

  const WishlistEntity({
    this.wishlistId,
    required this.userId,
    required this.products,
  });

  @override
  List<Object?> get props => [
        wishlistId,
        userId,
        products,
      ];

  factory WishlistEntity.empty() {
    return const WishlistEntity(
      wishlistId: null,
      userId: '',
      products: [],
    );
  }
}
