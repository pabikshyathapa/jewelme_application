import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/home/domain/use_case/product_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/home/domain/repository/product_repository.dart';

// Mock class
class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late AddProductUsecase usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = AddProductUsecase(productRepository: mockRepository);
  });

  const addParams = AddProductUseParams(
    name: 'Gold Bracelet',
    price: 799.99,
    categoryId: 'cat123',
    sellerId: 'seller123',
    filepath: 'images/bracelet.jpg',
    description: 'A beautiful gold bracelet.',
    stock: 10,
  );

  final expectedProduct = ProductEntity(
    productId: '',
    name: addParams.name,
    price: addParams.price,
    categoryId: addParams.categoryId,
    sellerId: addParams.sellerId,
    filepath: addParams.filepath,
    description: addParams.description,
    stock: addParams.stock,
  );

  test('should add product successfully', () async {
    // Arrange
    when(() => mockRepository.addProduct(expectedProduct))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(addParams);

    // Assert
    expect(result, const Right(null));
    verify(() => mockRepository.addProduct(expectedProduct)).called(1);
  });

  test('should return ServerFailure when add fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Failed to add');
    when(() => mockRepository.addProduct(expectedProduct))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(addParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.addProduct(expectedProduct)).called(1);
  });
}
