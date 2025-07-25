// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistApiModel _$WishlistApiModelFromJson(Map<String, dynamic> json) =>
    WishlistApiModel(
      wishlistId: json['_id'] as String?,
      userId: json['userId'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => WishlistItemApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WishlistApiModelToJson(WishlistApiModel instance) =>
    <String, dynamic>{
      '_id': instance.wishlistId,
      'userId': instance.userId,
      'products': instance.products,
    };
