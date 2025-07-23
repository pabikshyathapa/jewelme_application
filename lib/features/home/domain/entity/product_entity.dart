import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String productId;
  final String name;
  final double price;
  final String categoryId;
  final String sellerId;
  final String? filepath;
  final String? description;
  final int? stock;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductEntity({
    required this.productId,
    required this.name,
    required this.price,
    required this.categoryId,
    required this.sellerId,
    this.filepath,
    this.description,
    this.stock,
    this.createdAt,
    this.updatedAt, 
  });

  @override
  List<Object?> get props => [
    productId,
    name,
    price,
    categoryId,
    sellerId,
    filepath,
    description,
    stock,
    createdAt,
    updatedAt,
  ];
  factory ProductEntity.empty() {
    return const ProductEntity(
      productId: '',
      name: '',
      price: 0.0,
      categoryId: '',
      sellerId: '', 
    );
  }
}
