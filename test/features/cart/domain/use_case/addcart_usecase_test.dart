import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/cart/domain/use_case/addcart_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

// Mock repository
class MockCartRepository extends Mock implements ICartRepository {}

void main() {
  late AddToCartUsecase usecase;
  late MockCartRepository repository;

  setUp(() {
    repository = MockCartRepository();
    usecase = AddToCartUsecase(cartRepository: repository);

    // Register fallback for mocktail
    registerFallbackValue(ProductEntity.empty());
  });

  const userId = 'user123';
  const quantity = 2;

  final product = ProductEntity(
    productId: 'p1',
    name: 'Gold Ring',
    description: 'Shiny ring',
    filepath: 'http://image.com/ring.jpg',
    price: 149.99, categoryId: '', sellerId: '',
  );

  final params = AddToCartUseParams(
    userId: userId,
    product: product,
    quantity: quantity,
  );

  test('should return Right(null) when addToCart succeeds', () async {
    // Arrange
    when(() => repository.addToCart(
      userId: any(named: 'userId'),
      product: any(named: 'product'),
      quantity: any(named: 'quantity'),
    )).thenAnswer((_) async => Right(null));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Right<Failure, void>(null));
    verify(() => repository.addToCart(
      userId: userId,
      product: product,
      quantity: quantity,
    )).called(1);
  });

  test('should return Left(ServerFailure) when repository fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Server error');

    when(() => repository.addToCart(
      userId: any(named: 'userId'),
      product: any(named: 'product'),
      quantity: any(named: 'quantity'),
    )).thenAnswer((_) async => Left(failure)); 

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Left<Failure, void>(failure));
    verify(() => repository.addToCart(
      userId: userId,
      product: product,
      quantity: quantity,
    )).called(1);
  });
}
