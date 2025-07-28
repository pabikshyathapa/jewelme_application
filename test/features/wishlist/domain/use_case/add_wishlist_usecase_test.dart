import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/wishlist/domain/use_case/add_wishlist_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/wishlist/domain/repository/wishlist_repository.dart';

// Mock class
class MockWishlistRepository extends Mock implements IWishlistRepository {}

void main() {
  late AddToWishlistUsecase usecase;
  late MockWishlistRepository mockRepository;

  setUp(() {
    mockRepository = MockWishlistRepository();
    usecase = AddToWishlistUsecase(wishlistRepository: mockRepository);
  });

  const userId = 'user123';
  final product = ProductEntity(
    productId: 'prod456',
    name: 'Diamond Ring',
    price: 1500,
    description: 'Elegant diamond ring',
    filepath: 'https://example.com/image.jpg',
    categoryId: 'Jewelry', sellerId: '',
  );

  final params = AddToWishlistUseParams(userId: userId, product: product);

  test('should return void when add to wishlist is successful', () async {
    // Arrange
    when(() => mockRepository.addToWishlist(userId: userId, product: product))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right(null));
    verify(() => mockRepository.addToWishlist(userId: userId, product: product)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return ServerFailure when add to wishlist fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Failed to add to wishlist');

    when(() => mockRepository.addToWishlist(userId: userId, product: product))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.addToWishlist(userId: userId, product: product)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
