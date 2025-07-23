// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemApiModel _$CartItemApiModelFromJson(Map<String, dynamic> json) =>
    CartItemApiModel(
      productId: json['productId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      filepath: json['filepath'] as String,
    );

Map<String, dynamic> _$CartItemApiModelToJson(CartItemApiModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'filepath': instance.filepath,
    };
