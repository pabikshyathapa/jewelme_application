// import 'package:dartz/dartz.dart';
// import 'package:jewelme_application/core/error/failure.dart';
// import 'package:jewelme_application/features/home/data/data_source/local_datasource/product_local_datasource.dart';
// import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
// import 'package:jewelme_application/features/home/domain/repository/product_repository.dart';


// class ProductLocalRepository implements IProductRepository {
//   final ProductLocalDatasource _productLocalDatasource;

//   ProductLocalRepository({required ProductLocalDatasource productLocalDatasource})
//       : _productLocalDatasource = productLocalDatasource;

//   @override
//   Future<Either<Failure, void>> addProduct(ProductEntity product) async {
//     try {
//       await _productLocalDatasource.addProduct(product);
//       return Right(null);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: "Failed to add product: $e"));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> deleteProduct(String productId) async {
//     try {
//       await _productLocalDatasource.deleteProduct(productId);
//       return Right(null);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: "Failed to delete product: $e"));
//     }
//   }

//   @override
//   Future<Either<Failure, List<ProductEntity>>> fetchAllProducts() async {
//     try {
//       final products = await _productLocalDatasource.fetchAllProducts();
//       return Right(products);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: "Failed to fetch products: $e"));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> updateProduct(ProductEntity product) async {
//     try {
//       await _productLocalDatasource.updateProduct(product);
//       return Right(null);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: "Failed to update product: $e"));
//     }
//   }
// }
