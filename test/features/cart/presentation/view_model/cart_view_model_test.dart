import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/cart/domain/use_case/addcart_usecase.dart';
import 'package:jewelme_application/features/cart/domain/use_case/clear_cart_usecase.dart';
import 'package:jewelme_application/features/cart/domain/use_case/fetch_cart_usecase.dart';
import 'package:jewelme_application/features/cart/domain/use_case/remove_cart_usecase.dart';
import 'package:jewelme_application/features/cart/domain/use_case/update_cart_usecase.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_event.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

import 'package:mocktail/mocktail.dart';

// --- Mock classes ---
class MockAddToCartUsecase extends Mock implements AddToCartUsecase {}
class MockRemoveCartItemUseCase extends Mock implements RemoveCartItemUseCase {}
class MockUpdateCartQuantityUseCase extends Mock implements UpdateCartQuantityUseCase {}
class MockFetchCartUsecase extends Mock implements FetchCartUsecase {}
class MockClearCartUsecase extends Mock implements ClearCartUsecase {}

// Fake params for fallback value
class FakeAddToCartUseParams extends Fake implements AddToCartUseParams {}

void main() {
  late MockAddToCartUsecase mockAddToCartUsecase;

  setUpAll(() {
    registerFallbackValue(FakeAddToCartUseParams());
  });

  setUp(() {
    mockAddToCartUsecase = MockAddToCartUsecase();
  });

  testWidgets('CartViewModel emits loading and success and shows snackbar on AddToCartEvent', (tester) async {
    // Arrange
    when(() => mockAddToCartUsecase.call(any()))
      .thenAnswer((_) async => const Right(true));

    final cartViewModel = CartViewModel(
      addToCartUsecase: mockAddToCartUsecase,
      removeCartItemUsecase: MockRemoveCartItemUseCase(),
      updateCartItemQuantityUsecase: MockUpdateCartQuantityUseCase(),
      fetchCartUseCase: MockFetchCartUsecase(),
      clearCartUsecase: MockClearCartUsecase(),
    );

    // Create a real ProductEntity instance with dummy data (adjust constructor fields if different)
    final product = ProductEntity(
      productId: 'prod1',
      name: 'Test Product',
      price: 10.0,
      filepath: 'https://example.com/image.png',
      description: 'A test product', categoryId: '', sellerId: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: cartViewModel,
            child: Builder(
              builder: (context) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CartViewModel>().add(
                        AddToCartEvent(
                          userId: 'user1',
                          product: product,
                          quantity: 1,
                          context: context,
                        ),
                      );
                    },
                    child: const Text('Add To Cart'),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    // Act
    await tester.tap(find.text('Add To Cart'));
    await tester.pump(); // Let bloc emit loading state
    await tester.pump(const Duration(seconds: 1)); // Let snackbar appear

    // Assert
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to cart!'), findsOneWidget);
  });
}
