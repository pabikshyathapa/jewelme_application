import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/home/domain/repository/product_repository.dart';

class FetchAllProductsUsecase {
  final IProductRepository _productRepository;

  FetchAllProductsUsecase({
    required IProductRepository productRepository,
  }) : _productRepository = productRepository;

  Future<Either<Failure, List<ProductEntity>>> call({int page = 1, int limit = 9}) {
    return _productRepository.fetchAllProducts(page: page, limit: limit);
  }
}
