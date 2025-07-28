import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/home/domain/use_case/delete_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/home/domain/repository/product_repository.dart';

// Mock repository class
class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late DeleteProductUsecase usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = DeleteProductUsecase(productRepository: mockRepository);
  });

  const productId = 'prod123';

  test('should return Right(null) when deleteProduct succeeds', () async {
    // Arrange
    when(() => mockRepository.deleteProduct(productId))
        .thenAnswer((_) async => Right(null));

    // Act
    final result = await usecase(productId);

    // Assert
    expect(result, Right<Failure, void>(null));
    verify(() => mockRepository.deleteProduct(productId)).called(1);
  });

  test('should return Left(ServerFailure) when deleteProduct fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Failed to delete product');

    when(() => mockRepository.deleteProduct(productId))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(productId);

    // Assert
    expect(result, Left<Failure, void>(failure));
    verify(() => mockRepository.deleteProduct(productId)).called(1);
  });
}
