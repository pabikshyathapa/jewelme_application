import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'wishlist_item_api_model.dart';

part 'wishlist_api_model.g.dart';

@JsonSerializable()
class WishlistApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? wishlistId;
  final String userId;
  final List<WishlistItemApiModel> products;

  const WishlistApiModel({
    this.wishlistId,
    required this.userId,
    required this.products,
  });

  factory WishlistApiModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistApiModelToJson(this);

  WishlistEntity toEntity() => WishlistEntity(
        wishlistId: wishlistId,
        userId: userId,
        products: products.map((e) => e.toEntity()).toList(),
      );

  factory WishlistApiModel.fromEntity(WishlistEntity entity) =>
      WishlistApiModel(
        wishlistId: entity.wishlistId,
        userId: entity.userId,
        products:
            entity.products.map((e) => WishlistItemApiModel.fromEntity(e)).toList(),
      );

  @override
  List<Object?> get props => [wishlistId, userId, products];
}
