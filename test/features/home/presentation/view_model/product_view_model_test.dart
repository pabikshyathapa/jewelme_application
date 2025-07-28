import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/home/domain/use_case/delete_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/fetchall_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/product_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/update_usecase.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_event.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_view_model.dart';

// Mocks
class MockAddProductUsecase extends Mock implements AddProductUsecase {}
class MockUpdateProductUsecase extends Mock implements UpdateProductUsecase {}
class MockDeleteProductUsecase extends Mock implements DeleteProductUsecase {}
class MockFetchAllProductsUsecase extends Mock implements FetchAllProductsUsecase {}

class FakeAddProductUseParams extends Fake implements AddProductUseParams {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAddProductUseParams());
  });

  late MockAddProductUsecase mockAddProductUsecase;
  late MockFetchAllProductsUsecase mockFetchAllProductsUsecase;
  late ProductViewModel productViewModel;

  setUp(() {
    mockAddProductUsecase = MockAddProductUsecase();
    mockFetchAllProductsUsecase = MockFetchAllProductsUsecase();

    // Default return for fetch all products
    when(() => mockFetchAllProductsUsecase.call())
        .thenAnswer((_) async => const Right(<ProductEntity>[]));

    productViewModel = ProductViewModel(
      addProductUsecase: mockAddProductUsecase,
      updateProductUsecase: MockUpdateProductUsecase(),
      deleteProductUsecase: MockDeleteProductUsecase(),
      fetchAllProductsUsecase: mockFetchAllProductsUsecase,
    );
  });

  testWidgets('shows SnackBar when AddProductEvent is added successfully', (tester) async {
  // Arrange
  when(() => mockAddProductUsecase.call(any()))
      .thenAnswer((_) async => const Right(null));

  final product = ProductEntity(
    productId: '1',
    name: 'Test Product',
    categoryId: 'cat1',
    sellerId: 'seller1',
    price: 100.0,
    filepath: 'path/to/image.png',
    description: 'Test product description',
    stock: 10,
  );

  await tester.pumpWidget(
    MaterialApp(
      home: ScaffoldMessenger(
        child: Scaffold(
          body: BlocProvider<ProductViewModel>.value(
            value: productViewModel,
            child: Builder(
              builder: (context) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ProductViewModel>().add(
                            AddProductEvent(
                              context: context, // This context is inside Scaffold!
                              product: product,
                            ),
                          );
                    },
                    child: const Text('Add Product'),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ),
  );

  // Act
  await tester.tap(find.text('Add Product'));
  await tester.pump(); // process event
  await tester.pump(const Duration(seconds: 1)); // show SnackBar animation

  // Assert
  expect(find.byType(SnackBar), findsOneWidget);
  expect(find.text('Product added successfully'), findsOneWidget);
});
}