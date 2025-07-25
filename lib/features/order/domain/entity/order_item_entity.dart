import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String filepath;

  const OrderItemEntity({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.filepath,
  });

  @override
  List<Object?> get props => [productId, name, price, quantity, filepath];

  factory OrderItemEntity.fromJson(Map<String, dynamic> json) {
    return OrderItemEntity(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      filepath: json['filepath'] ?? '',
    );
  }
}
