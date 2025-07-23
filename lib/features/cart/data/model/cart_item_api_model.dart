import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_api_model.g.dart';

@JsonSerializable()
class CartItemApiModel extends Equatable {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String filepath;

  const CartItemApiModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.filepath,
  });

  factory CartItemApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemApiModelToJson(this);

  CartItemEntity toEntity() => CartItemEntity(
        productId: productId,
        name: name,
        price: price,
        quantity: quantity,
        filepath: filepath,
      );

  factory CartItemApiModel.fromEntity(CartItemEntity entity) =>
      CartItemApiModel(
        productId: entity.productId,
        name: entity.name,
        price: entity.price,
        quantity: entity.quantity,
        filepath: entity.filepath,
      );

  @override
  List<Object?> get props => [productId, name, price, quantity, filepath];
}
