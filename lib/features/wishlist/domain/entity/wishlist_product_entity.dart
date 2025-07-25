import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

class WishlistItemEntity extends Equatable {
  final String productId;
  final String name;
  final double price;
  final String filepath;
  final String description;
  final String category;

  const WishlistItemEntity({
    required this.productId,
    required this.name,
    required this.price,
    required this.filepath,
    required this.description,
    required this.category,
  });

  @override
  List<Object?> get props => [
        productId,
        name,
        price,
        filepath,
        description,
        category,
      ];

  WishlistItemEntity copyWith({
    String? productId,
    String? name,
    double? price,
    String? filepath,
    String? description,
    String? category,
  }) {
    return WishlistItemEntity(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      filepath: filepath ?? this.filepath,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }

  factory WishlistItemEntity.empty() {
    return const WishlistItemEntity(
      productId: '',
      name: '',
      price: 0.0,
      filepath: '',
      description: '',
      category: '',
    );
  }

  ProductEntity toProductEntity() {
    return ProductEntity(
      productId: productId,
      name: name,
      price: price,
      filepath: filepath,
      description: description,
      categoryId: '',
       sellerId: '',
    );
  }
}
