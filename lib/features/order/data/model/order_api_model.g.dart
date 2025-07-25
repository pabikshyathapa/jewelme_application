// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderApiModel _$OrderApiModelFromJson(Map<String, dynamic> json) =>
    OrderApiModel(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => OrderItemApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$OrderApiModelToJson(OrderApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'products': instance.products,
      'totalAmount': instance.totalAmount,
      'createdAt': instance.createdAt.toIso8601String(),
    };
