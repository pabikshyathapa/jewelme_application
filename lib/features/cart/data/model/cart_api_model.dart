import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/cart_entity.dart';
import 'cart_item_api_model.dart';

part 'cart_api_model.g.dart';

@JsonSerializable()
class CartApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? cartId;
  final String userId;
  final List<CartItemApiModel> products;

  const CartApiModel({
    this.cartId,
    required this.userId,
    required this.products,
  });

  factory CartApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartApiModelToJson(this);

  CartEntity toEntity() => CartEntity(
        cartId: cartId,
        userId: userId,
        products: products.map((e) => e.toEntity()).toList(),
      );

  factory CartApiModel.fromEntity(CartEntity entity) => CartApiModel(
        cartId: entity.cartId,
        userId: entity.userId,
        products: entity.products
            .map((e) => CartItemApiModel.fromEntity(e))
            .toList(),
      );

  @override
  List<Object?> get props => [cartId, userId, products];
}
