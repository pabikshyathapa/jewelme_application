// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(Map<String, dynamic> json) =>
    ProductApiModel(
      productId: json['_id'] as String?,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      categoryId: json['categoryId'] as Map<String, dynamic>,
      sellerId: json['sellerId'] as Map<String, dynamic>,
      filepath: json['filepath'] as String?,
      description: json['description'] as String?,
      stock: (json['stock'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.productId,
      'name': instance.name,
      'price': instance.price,
      'categoryId': instance.categoryId,
      'sellerId': instance.sellerId,
      'filepath': instance.filepath,
      'description': instance.description,
      'stock': instance.stock,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
