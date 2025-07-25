import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/order_item_entity.dart';

part 'order_item_api_model.g.dart';

@JsonSerializable()
class OrderItemApiModel extends Equatable {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String filepath;

  const OrderItemApiModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.filepath,
  });

  factory OrderItemApiModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemApiModelToJson(this);

  OrderItemEntity toEntity() => OrderItemEntity(
        productId: productId,
        name: name,
        price: price,
        quantity: quantity,
        filepath: filepath,
      );

  factory OrderItemApiModel.fromEntity(OrderItemEntity entity) =>
      OrderItemApiModel(
        productId: entity.productId,
        name: entity.name,
        price: entity.price,
        quantity: entity.quantity,
        filepath: entity.filepath,
      );

  @override
  List<Object?> get props => [productId, name, price, quantity, filepath];
}
