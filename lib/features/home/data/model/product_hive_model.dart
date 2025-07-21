import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jewelme_application/app/constant/hive_table_constant.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:uuid/uuid.dart';

part 'product_hive_model.g.dart';
@HiveType(typeId: HiveTableConstant.productTableId)
class ProductHiveModel extends Equatable {
  @HiveField(0)
  final String productId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String categoryId;

  @HiveField(4)
  final String sellerId;

  @HiveField(5)
  final String? filepath;

  @HiveField(6)
  final String? description;

  @HiveField(7)
  final int stock;

  @HiveField(8)
  final DateTime? createdAt;

  @HiveField(9)
  final DateTime? updatedAt;

  ProductHiveModel({
    String? productId,
    required this.name,
    required this.price,
    required this.categoryId,
    required this.sellerId,
    this.filepath,
    this.description,
    this.stock = 0,
    this.createdAt,
    this.updatedAt,
  }) : productId = productId ?? const Uuid().v4();

  const ProductHiveModel.initial()
      : productId = '',
        name = '',
        price = 0.0,
        categoryId = '',
        sellerId = '',
        filepath = '',
        description = '',
        stock = 0,
        createdAt = null,
        updatedAt = null;

  factory ProductHiveModel.fromEntity(ProductEntity entity) {
    return ProductHiveModel(
      productId: entity.productId,
      name: entity.name,
      price: entity.price,
      categoryId: entity.categoryId,
      sellerId: entity.sellerId,
      filepath: entity.filepath,
      description: entity.description,
      stock: entity.stock ?? 0,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      productId: productId,
      name: name,
      price: price,
      categoryId: categoryId,
      sellerId: sellerId,
      filepath: filepath,
      description: description,
      stock: stock,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
  
  @override
  List<Object?> get props =>[productId,
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