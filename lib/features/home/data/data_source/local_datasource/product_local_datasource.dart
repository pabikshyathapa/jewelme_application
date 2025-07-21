// import 'package:jewelme_application/core/network/hive_service.dart';
// import 'package:jewelme_application/features/home/data/data_source/product_data_source.dart';
// import 'package:jewelme_application/features/home/data/model/product_hive_model.dart';
// import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';


// class ProductLocalDatasource implements IProductDataSource {
//   final HiveService _hiveService;

//   ProductLocalDatasource({required HiveService hiveService}) : _hiveService = hiveService;

//   @override
//   Future<List<ProductEntity>> fetchAllProducts() async {
//     final products = await _hiveService.getAllProducts();
//     return products.map((e) => e.toEntity()).toList();
//   }

//   @override
//   Future<void> addProduct(ProductEntity product) async {
//     final productHiveModel = ProductHiveModel.fromEntity(product);
//     await _hiveService.addProduct(productHiveModel);
//   }

//   @override
//   Future<void> updateProduct(ProductEntity product) async {
//     final productHiveModel = ProductHiveModel.fromEntity(product);
//     await _hiveService.updateProduct(productHiveModel);
//   }

//   @override
//   Future<void> deleteProduct(String productId) async {
//     await _hiveService.deleteProduct(productId);
//   }

//   @override
//   Future<ProductEntity> fetchProductById(String productId) {
//     // TODO: implement fetchProductById
//     throw UnimplementedError();
//   }
// }
