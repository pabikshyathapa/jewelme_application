import 'package:dio/dio.dart';
import 'package:jewelme_application/core/network/api_sevice.dart';
import 'package:jewelme_application/app/constant/api_endpoints.dart';
import 'package:jewelme_application/features/home/data/data_source/product_data_source.dart';
import 'package:jewelme_application/features/home/data/model/product_api_model.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

class ProductRemoteDatasource implements IProductDataSource {
  final ApiService _apiService;

  ProductRemoteDatasource({required ApiService apiService})
      : _apiService = apiService;

@override
Future<List<ProductEntity>> fetchAllProducts({int page = 1, int limit = 9}) async {
  try {
    final response = await _apiService.dio.get(
      ApiEndpoints.getAllProducts,
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );

    final responseData = response.data as Map<String, dynamic>;
    final dataList = responseData['data'] as List;

    return dataList
        .map((json) => ProductApiModel.fromJson(json as Map<String, dynamic>).toEntity())
        .toList();
  } on DioException catch (e) {
    throw Exception("Failed to fetch products: ${e.message}");
  }
}

  @override
  Future<void> addProduct(ProductEntity product) async {
    try {
      final model = ProductApiModel.fromEntity(product);
      await _apiService.dio.post(ApiEndpoints.createProduct, data: model.toJson());
    } catch (e) {
      throw Exception("Failed to add product: $e");
    }
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    try {
      final model = ProductApiModel.fromEntity(product);
      await _apiService.dio.put("${ApiEndpoints.updateProduct}/${product.productId}", data: model.toJson());
    } catch (e) {
      throw Exception("Failed to update product: $e");
    }
  }

  @override
  Future<void> deleteProduct(String productId) async {
    try {
      await _apiService.dio.delete("${ApiEndpoints.deleteProduct}/$productId");
    } catch (e) {
      throw Exception("Failed to delete product: $e");
    }
  }

  @override
  Future<ProductEntity> fetchProductById(String productId) {
    // TODO: implement fetchProductById
    throw UnimplementedError();
  }
}
