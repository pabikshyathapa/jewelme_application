import 'package:equatable/equatable.dart';
import 'order_item_entity.dart';

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final List<OrderItemEntity> products;
  final double totalAmount;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, products, totalAmount, createdAt];

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    return OrderEntity(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      products: (json['products'] as List<dynamic>)
          .map((e) => OrderItemEntity.fromJson(e))
          .toList(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
