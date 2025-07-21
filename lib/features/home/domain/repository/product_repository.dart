import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

abstract interface class IProductRepository {
Future<Either<Failure, List<ProductEntity>>> fetchAllProducts({int page = 1, int limit = 9});

  Future<Either<Failure, void>> addProduct(ProductEntity product);

  Future<Either<Failure, void>> updateProduct(ProductEntity product);

  Future<Either<Failure, void>> deleteProduct(String productId);
}
