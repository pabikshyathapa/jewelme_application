import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_api_model.g.dart';
@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? productId;
  final String name;
  final double price;
  final Map<String, dynamic> categoryId;
  final Map<String, dynamic> sellerId;
  final String? filepath; 
  final String? description;
  final int? stock;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductApiModel({
    this.productId,
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

  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  ProductEntity toEntity() {
    return ProductEntity(
      productId: productId ?? '',
      name: name,
      price: price,
       categoryId: categoryId['_id'] ?? '',
      sellerId: sellerId['_id'] ?? '',
      filepath: filepath,
      description: description,
      stock: stock,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory ProductApiModel.fromEntity(ProductEntity entity) {
    return ProductApiModel(
      productId: entity.productId,
      name: entity.name,
      price: entity.price,
      categoryId: {
      '_id': entity.categoryId,
    },
    sellerId: {
      '_id': entity.sellerId,
    },
      filepath: entity.filepath,
      description: entity.description,
      stock: entity.stock,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

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
}
