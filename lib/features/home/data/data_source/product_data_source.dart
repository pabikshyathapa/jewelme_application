
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

abstract interface class IProductDataSource {
  Future<List<ProductEntity>> fetchAllProducts();

  Future<ProductEntity> fetchProductById(String productId);

  Future<void> addProduct(ProductEntity product);

  Future<void> updateProduct(ProductEntity product);

  Future<void> deleteProduct(String productId);
}