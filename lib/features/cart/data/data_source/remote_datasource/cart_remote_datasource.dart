import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jewelme_application/app/constant/api_endpoints.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/core/network/api_sevice.dart';
import 'package:jewelme_application/features/cart/data/data_source/cart_data_source.dart';
import 'package:jewelme_application/features/cart/data/model/cart_api_model.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_entity.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_item_entity.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

class CartRemoteDatasource implements ICartDataSource {
  final ApiService _apiService;

  CartRemoteDatasource({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<Either<Failure, void>> addToCart({
    required String userId,
    required ProductEntity product,
    required int quantity,
  }) async {
    try {
      final response = await _apiService.dio.post(
        ApiEndpoints.addToCart,
        data: {
          'userId': userId,
          'productId': product.productId,
          'name': product.name,
          'price': product.price,
          'quantity': quantity,
          'filepath': product.filepath ?? '',
        },
      );

      if (response.statusCode != 201) {
        return Left(RemoteDatabaseFailure(message: response.statusMessage ?? 'Unknown error'));
      }

      return const Right(null);
    } on DioException catch (e) {
      return Left(RemoteDatabaseFailure(message: e.message ?? 'Dio error'));
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }


  @override
  Future<CartEntity> getCartByUser(String userId) async {
    try {
      final response = await _apiService.dio.get('${ApiEndpoints.getCartByUser}/$userId');
      if (response.statusCode == 200) {
        final cartApiModel = CartApiModel.fromJson(response.data['data']);
        return cartApiModel.toEntity();
      } else {
        throw Exception('Failed to fetch cart: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch cart: $e');
    }
  }

  @override
  Future<void> updateCartItemQuantity({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    try {
      final response = await _apiService.dio.put(
        ApiEndpoints.updateCartItem, // e.g. '/api/cart/update'
        data: {
          'userId': userId,
          'productId': productId,
          'quantity': quantity,
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update cart item: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to update cart item: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update cart item: $e');
    }
  }

  @override
  Future<void> removeCartItem({
    required String userId,
    required String productId,
  }) async {
    try {
      final response = await _apiService.dio.delete(
        ApiEndpoints.removeCartItem, // e.g. '/api/cart/remove'
        data: {
          'userId': userId,
          'productId': productId,
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to remove cart item: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to remove cart item: ${e.message}');
    } catch (e) {
      throw Exception('Failed to remove cart item: $e');
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    try {
      final response = await _apiService.dio.delete('${ApiEndpoints.clearCart}/$userId');
      if (response.statusCode != 200) {
        throw Exception('Failed to clear cart: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to clear cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  @override
  Future<List<CartEntity>> getAllCartItems() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAllCartItems); // e.g. '/api/cart/'
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => CartApiModel.fromJson(json).toEntity()).toList();
      } else {
        throw Exception('Failed to fetch all cart items: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch all cart items: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch all cart items: $e');
    }
  }
  @override
Future<List<CartItemEntity>> fetchCart(String userId) async {
  try {
    final response = await _apiService.dio.get('${ApiEndpoints.getCartByUser}/$userId');

    if (response.statusCode == 200) {
      // Assuming response.data['data']['products'] contains list of product items in cart
      final productsJson = response.data['data']['products'] as List<dynamic>;

      // Map each product JSON to CartItemEntity
      final cartItems = productsJson.map((json) {
        return CartItemEntity(
          productId: json['productId'] as String,
          name: json['name'] as String,
          price: (json['price'] as num).toDouble(),
          quantity: json['quantity'] as int,
          filepath: json['filepath'] as String,
        );
      }).toList();

      return cartItems;
    } else {
      throw Exception('Failed to fetch cart items: ${response.statusMessage}');
    }
  } on DioException catch (e) {
    throw Exception('Failed to fetch cart items: ${e.message}');
  } catch (e) {
    throw Exception('Failed to fetch cart items: $e');
  }
}

}
