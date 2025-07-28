import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:jewelme_application/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:jewelme_application/features/wishlist/domain/entity/wishlist_product_entity.dart';

// Mock class
class MockWishlistRepository extends Mock implements IWishlistRepository {}

void main() {
  late MockWishlistRepository mockRepository;

  setUp(() {
    mockRepository = MockWishlistRepository();
  });

  const userId = 'user123';
  final wishlistItems = [
    WishlistItemEntity(
      productId: 'prod001',
      name: 'Gold Necklace',
      price: 2500.0,
      filepath: 'https://example.com/image.jpg',
      description: 'Elegant gold necklace',
      category: 'Jewelry',
    ),
  ];

  test('should return wishlist items when fetchWishlistItems is successful', () async {
    // Arrange
    when(() => mockRepository.fetchWishlistItems(userId))
        .thenAnswer((_) async => Right(wishlistItems));

    // Act
    final result = await mockRepository.fetchWishlistItems(userId);

    // Assert
    expect(result, Right(wishlistItems));
    verify(() => mockRepository.fetchWishlistItems(userId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when fetchWishlistItems fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Server error');
    when(() => mockRepository.fetchWishlistItems(userId))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await mockRepository.fetchWishlistItems(userId);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.fetchWishlistItems(userId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
