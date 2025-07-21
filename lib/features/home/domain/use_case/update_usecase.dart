import 'package:dartz/dartz.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/home/domain/repository/product_repository.dart';

class UpdateProductUsecase implements UsecaseWithParams<void, ProductEntity> {
  final IProductRepository _productRepository;

  UpdateProductUsecase({
    required IProductRepository productRepository,
  }) : _productRepository = productRepository;

  @override
  Future<Either<Failure, void>> call(ProductEntity product) {
    return _productRepository.updateProduct(product);
  }
}
