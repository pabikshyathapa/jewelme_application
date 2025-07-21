import 'package:dartz/dartz.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/home/domain/repository/product_repository.dart';

class DeleteProductUsecase implements UsecaseWithParams<void, String> {
  final IProductRepository _productRepository;

  DeleteProductUsecase({
    required IProductRepository productRepository,
  }) : _productRepository = productRepository;

  @override
  Future<Either<Failure, void>> call(String productId) {
    return _productRepository.deleteProduct(productId);
  }
}
