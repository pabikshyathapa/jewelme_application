import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/home/domain/use_case/delete_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/fetchall_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/product_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/update_usecase.dart';
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

}