import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/home/domain/use_case/update_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/home/domain/repository/product_repository.dart';

// Mock repository
class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late UpdateProductUsecase usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = UpdateProductUsecase(productRepository: mockRepository);
  });

  const product = ProductEntity(
    productId: '1',
    name: 'Emerald Bracelet',
    price: 1299.99,
    categoryId: 'c3',
    sellerId: 's3',
    filepath: 'image.jpg',
    description: 'Genuine emerald bracelet',
    stock: 20,
  );

  test('should return void when update is successful', () async {
    // Arrange
    when(() => mockRepository.updateProduct(product))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(product);

    // Assert
    expect(result, const Right(null));
    verify(() => mockRepository.updateProduct(product)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when update fails', () async {
    // Arrange
    const failure = ServerFailure(message: 'Update failed');
    when(() => mockRepository.updateProduct(product))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await usecase(product);

    // Assert
    expect(result, const Left(failure));
    verify(() => mockRepository.updateProduct(product)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
