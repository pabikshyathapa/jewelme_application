// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemApiModel _$OrderItemApiModelFromJson(Map<String, dynamic> json) =>
    OrderItemApiModel(
      productId: json['productId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      filepath: json['filepath'] as String,
    );

Map<String, dynamic> _$OrderItemApiModelToJson(OrderItemApiModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'filepath': instance.filepath,
    };
