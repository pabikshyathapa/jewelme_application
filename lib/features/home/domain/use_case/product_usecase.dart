import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/home/domain/repository/product_repository.dart';

class AddProductUseParams extends Equatable {
  final String name;
  final String categoryId;
  final String sellerId;
  final double price;
  final String filepath;
  final String description;
  final int stock;

  const AddProductUseParams({
    required this.name,
    required this.categoryId,
    required this.sellerId,
    required this.price,
    required this.filepath,
    required this.description,
    required this.stock,
  });

  const AddProductUseParams.initial({
    this.name = '',
    this.categoryId = '',
    this.sellerId = '',
    this.price = 0,
    this.filepath = '',
    this.description = '',
    this.stock = 0,
  });

  @override
  List<Object?> get props => [
        name,
        categoryId,
        sellerId,
        price,
        filepath,
        description,
        stock,
      ];
}


class AddProductUsecase implements UsecaseWithParams<void, AddProductUseParams> {
  final IProductRepository _productRepository;

  AddProductUsecase({
    required IProductRepository productRepository,
  }) : _productRepository = productRepository;

  @override
  Future<Either<Failure, void>> call(AddProductUseParams params) {
    final productEntity = ProductEntity(
      productId: '',
      name: params.name,
      categoryId: params.categoryId,
      sellerId: params.sellerId,
      price: params.price,
      filepath: params.filepath,
      description: params.description,
      stock: params.stock, 
    );

    return _productRepository.addProduct(productEntity);
  }
}
