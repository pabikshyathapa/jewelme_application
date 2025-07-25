import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wishlist_item_api_model.g.dart';

@JsonSerializable()
class WishlistItemApiModel extends Equatable {
  final String productId;
  final String name;
  final double price;
  final String filepath;

  const WishlistItemApiModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.filepath,
  });

  factory WishlistItemApiModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistItemApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistItemApiModelToJson(this);

  WishlistItemEntity toEntity() => WishlistItemEntity(
        productId: productId,
        name: name,
        price: price,
        filepath: filepath, 
        description: '',
         category: '',
      );

  factory WishlistItemApiModel.fromEntity(WishlistItemEntity entity) =>
      WishlistItemApiModel(
        productId: entity.productId,
        name: entity.name,
        price: entity.price,
        filepath: entity.filepath,
      );

  @override
  List<Object?> get props => [productId, name, price, filepath];
}
