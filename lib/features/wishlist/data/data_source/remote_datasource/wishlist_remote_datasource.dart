import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jewelme_application/app/constant/api_endpoints.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/core/network/api_sevice.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/wishlist/data/data_source/wishlist_data_source.dart';
import 'package:jewelme_application/features/wishlist/data/model/wishlist_api_model.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_product_entity.dart';

class WishlistRemoteDatasource implements IWishlistDataSource {
  final ApiService _apiService;

  WishlistRemoteDatasource({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<Either<Failure, void>> addToWishlist({
    required String userId,
    required ProductEntity product,
  }) async {
    try {
      final response = await _apiService.dio.post(
        ApiEndpoints.addToWishlist, // e.g. /api/wishlist/add
        data: {
          'userId': userId,
          'productId': product.productId,
          'name': product.name,
          'price': product.price,
          'filepath': product.filepath ?? '',
        },
      );

      if (response.statusCode != 200) {
        return Left(RemoteDatabaseFailure(message: response.statusMessage ?? 'Failed to add'));
      }

      return const Right(null);
    } on DioException catch (e) {
      return Left(RemoteDatabaseFailure(message: e.message ?? 'Dio error'));
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<WishlistEntity> getWishlistByUser(String userId) async {
    try {
      final response = await _apiService.dio.get('${ApiEndpoints.getWishlistByUser}/$userId');
      if (response.statusCode == 200) {
        final wishlistApiModel = WishlistApiModel.fromJson(response.data['data']);
        return wishlistApiModel.toEntity();
      } else {
        throw Exception('Failed to fetch wishlist: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch wishlist: $e');
    }
  }

  @override
  Future<void> removeWishlistItem({
    required String userId,
    required String productId,
  }) async {
    try {
      final response = await _apiService.dio.post(
        ApiEndpoints.removeFromWishlist, // e.g. /api/wishlist/remove
        data: {
          'userId': userId,
          'productId': productId,
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to remove wishlist item: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to remove wishlist item: ${e.message}');
    } catch (e) {
      throw Exception('Failed to remove wishlist item: $e');
    }
  }

  @override
  Future<List<WishlistItemEntity>> fetchWishlistItems(String userId) async {
    try {
      final response = await _apiService.dio.get('${ApiEndpoints.getWishlistByUser}/$userId');
      if (response.statusCode == 200) {
        final productsJson = response.data['data']['products'] as List<dynamic>;

        final wishlistItems = productsJson.map((json) {
          return WishlistItemEntity(
            productId: json['productId'] as String,
            name: json['name'] as String,
            price: (json['price'] as num).toDouble(),
            filepath: json['filepath'] as String, description: '', category: '',
          );
        }).toList();

        return wishlistItems;
      } else {
        throw Exception('Failed to fetch wishlist items: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch wishlist items: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch wishlist items: $e');
    }
  }
}
