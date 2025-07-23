// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartApiModel _$CartApiModelFromJson(Map<String, dynamic> json) => CartApiModel(
      cartId: json['_id'] as String?,
      userId: json['userId'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => CartItemApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartApiModelToJson(CartApiModel instance) =>
    <String, dynamic>{
      '_id': instance.cartId,
      'userId': instance.userId,
      'products': instance.products,
    };
