import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/home/domain/use_case/fetchall_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/home/domain/repository/product_repository.dart';

// Mock repository
class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late FetchAllProductsUsecase usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = FetchAllProductsUsecase(productRepository: mockRepository);
  });

  const page = 1;
  const limit = 9;

  final products = [
    const ProductEntity(
      productId: '1',
      name: 'Gold Necklace',
      price: 999.99,
      categoryId: 'c1',
      sellerId: 's1',
    ),
    const ProductEntity(
      productId: '2',
      name: 'Diamond Ring',
      price: 1499.99,
      categoryId: 'c2',
      sellerId: 's2',
    ),
  ];

  test('should return list of products when fetch is successful', () async {
    // Arrange
    when(() => mockRepository.fetchAllProducts(page: page, limit: limit))
        .thenAnswer((_) async => Right(products));

    // Act
    final result = await usecase(page: page, limit: limit);

    // Assert
    expect(result, Right(products));
    verify(() => mockRepository.fetchAllProducts(page: page, limit: limit)).called(1);
  });

  test('should return failure when fetch fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Fetch failed');

    when(() => mockRepository.fetchAllProducts(page: page, limit: limit))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(page: page, limit: limit);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.fetchAllProducts(page: page, limit: limit)).called(1);
  });
}
