import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/wishlist/domain/use_case/remove_wishlist_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:jewelme_application/core/error/server_failure.dart';
import 'package:jewelme_application/features/wishlist/domain/repository/wishlist_repository.dart';

// Mock class for IWishlistRepository
class MockWishlistRepository extends Mock implements IWishlistRepository {}

void main() {
  late RemoveWishlistItemUseCase usecase;
  late MockWishlistRepository mockWishlistRepository;

  setUp(() {
    mockWishlistRepository = MockWishlistRepository();
    usecase = RemoveWishlistItemUseCase(mockWishlistRepository);
  });

  const userId = 'user123';
  const productId = 'prod456';

  final params = RemoveWishlistItemParams(userId: userId, productId: productId);

  test('should remove wishlist item successfully', () async {
    // Arrange
    when(() => mockWishlistRepository.removeWishlistItem(
          userId: any(named: 'userId'),
          productId: any(named: 'productId'),
        )).thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right(null));
    verify(() => mockWishlistRepository.removeWishlistItem(
          userId: userId,
          productId: productId,
        )).called(1);
    verifyNoMoreInteractions(mockWishlistRepository);
  });

  test('should return ServerFailure when repository fails', () async {
    // Arrange
    const failure = ServerFailure(message: 'Unable to remove item');

    when(() => mockWishlistRepository.removeWishlistItem(
          userId: any(named: 'userId'),
          productId: any(named: 'productId'),
        )).thenAnswer((_) async => const Left(failure));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Left(failure));
    verify(() => mockWishlistRepository.removeWishlistItem(
          userId: userId,
          productId: productId,
        )).called(1);
    verifyNoMoreInteractions(mockWishlistRepository);
  });
}
