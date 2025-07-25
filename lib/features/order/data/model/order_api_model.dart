import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/order_entity.dart';
import 'order_item_api_model.dart';

part 'order_api_model.g.dart';

@JsonSerializable()
class OrderApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String userId;
  final List<OrderItemApiModel> products;
  final double totalAmount;
  final DateTime createdAt;

  const OrderApiModel({
    required this.id,
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.createdAt,
  });

  factory OrderApiModel.fromJson(Map<String, dynamic> json) =>
      _$OrderApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderApiModelToJson(this);

  OrderEntity toEntity() => OrderEntity(
        id: id,
        userId: userId,
        products: products.map((e) => e.toEntity()).toList(),
        totalAmount: totalAmount,
        createdAt: createdAt,
      );

  factory OrderApiModel.fromEntity(OrderEntity entity) => OrderApiModel(
        id: entity.id,
        userId: entity.userId,
        products: entity.products
            .map((e) => OrderItemApiModel.fromEntity(e))
            .toList(),
        totalAmount: entity.totalAmount,
        createdAt: entity.createdAt,
      );

  @override
  List<Object?> get props => [id, userId, products, totalAmount, createdAt];
}
