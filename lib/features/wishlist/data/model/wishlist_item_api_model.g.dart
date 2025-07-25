// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_item_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistItemApiModel _$WishlistItemApiModelFromJson(
        Map<String, dynamic> json) =>
    WishlistItemApiModel(
      productId: json['productId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      filepath: json['filepath'] as String,
    );

Map<String, dynamic> _$WishlistItemApiModelToJson(
        WishlistItemApiModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'price': instance.price,
      'filepath': instance.filepath,
    };
