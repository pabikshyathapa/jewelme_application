import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String filepath;

  const CartItemEntity({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.filepath,
  });

  @override
  List<Object?> get props => [
        productId,
        name,
        price,
        quantity,
        filepath,
      ];

     CartItemEntity copyWith({
    String? productId,
    String? name,
    double? price,
    int? quantity,
    String? filepath,
  }) {
    return CartItemEntity(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      filepath: filepath ?? this.filepath,
    );
  }

  factory CartItemEntity.empty() {
    return const CartItemEntity(
      productId: '',
      name: '',
      price: 0.0,
      quantity: 0,
      filepath: '',
    );
  }
  
}
