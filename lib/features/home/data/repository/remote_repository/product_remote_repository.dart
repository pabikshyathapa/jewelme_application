import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/home/data/data_source/remote_datasource/product_remote_datesource.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/home/domain/repository/product_repository.dart';

class ProductRemoteRepository implements IProductRepository {
  final ProductRemoteDatasource _productRemoteDatasource;

  ProductRemoteRepository({
    required ProductRemoteDatasource productRemoteDatasource,
  }) : _productRemoteDatasource = productRemoteDatasource;

  @override
Future<Either<Failure, List<ProductEntity>>> fetchAllProducts({int page = 1, int limit = 9}) async {
  try {
    final products = await _productRemoteDatasource.fetchAllProducts(page: page, limit: limit);
    return Right(products);
  } catch (e) {
    return Left(RemoteDatabaseFailure(message: e.toString()));
  }
}


  @override
  Future<Either<Failure, void>> addProduct(ProductEntity product) async {
    try {
      await _productRemoteDatasource.addProduct(product);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity product) async {
    try {
      await _productRemoteDatasource.updateProduct(product);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    try {
      await _productRemoteDatasource.deleteProduct(productId);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}
