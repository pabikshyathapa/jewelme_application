import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/home/presentation/view/home_page.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jewelme_application/features/home/presentation/view_model/product_view_model.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_event.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_state.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/core/utils/user_session.dart';

// --- Fake classes for mocktail fallback values ---
class FakeCartEvent extends Fake {}
class FakeFetchAllProductsEvent extends Fake implements FetchAllProductsEvent {}
class FakeProductState extends Fake implements ProductState {}

// --- Mock class ---
class MockProductViewModel extends Mock implements ProductViewModel {}

void main() {
  late MockProductViewModel mockProductViewModel;

  setUpAll(() {
  registerFallbackValue(FetchAllProductsEvent(page: 1, limit: 12));
  registerFallbackValue(ProductState.initial());
});


  setUp(() {
    mockProductViewModel = MockProductViewModel();

    when(() => mockProductViewModel.state).thenReturn(ProductState.initial());
    when(() => mockProductViewModel.stream).thenAnswer((_) => Stream.value(ProductState.initial()));

    when(() => mockProductViewModel.add(any())).thenReturn(null);

    UserSession.instance.userId = 'test_user'; // mock logged-in user
  });

  // Helper widget to provide BlocProvider
  Widget _wrapWithBlocAndDummyWishlist(Widget child) {
    return BlocProvider<ProductViewModel>.value(
      value: mockProductViewModel,
      child: MaterialApp(home: Scaffold(body: child)),
    );
  }

  testWidgets('Shows loading indicator when loading and no products', (tester) async {
    final loadingState = ProductState(
      isLoading: true,
      isLoadingMore: false,
      isSuccess: false,
      products: [],
      errorMessage: null,
      currentPage: 1,
      hasMorePages: true,
    );

    when(() => mockProductViewModel.state).thenReturn(loadingState);
    when(() => mockProductViewModel.stream).thenAnswer((_) => Stream.value(loadingState));

    await tester.pumpWidget(_wrapWithBlocAndDummyWishlist(const HomeViewPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Shows error message when error occurs', (tester) async {
    final errorState = ProductState(
      isLoading: false,
      isLoadingMore: false,
      isSuccess: false,
      products: [],
      errorMessage: 'Failed to load products',
      currentPage: 1,
      hasMorePages: false,
    );

    when(() => mockProductViewModel.state).thenReturn(errorState);
    when(() => mockProductViewModel.stream).thenAnswer((_) => Stream.value(errorState));

    await tester.pumpWidget(_wrapWithBlocAndDummyWishlist(const HomeViewPage()));
    await tester.pump();

    expect(find.text('Error: Failed to load products'), findsOneWidget);
  });

  testWidgets('Shows list of products and allows search filtering', (tester) async {
    final product1 = ProductEntity(
      productId: 'p1',
      name: 'Apple Watch',
      price: 200,
      categoryId: 'c1',
      sellerId: 's1',
      filepath: '',
      description: 'Smart watch',
    );

    final product2 = ProductEntity(
      productId: 'p2',
      name: 'Banana Phone',
      price: 100,
      categoryId: 'c2',
      sellerId: 's2',
      filepath: '',
      description: 'Funny phone',
    );

    final loadedState = ProductState(
      isLoading: false,
      isLoadingMore: false,
      isSuccess: true,
      products: [product1, product2],
      errorMessage: null,
      currentPage: 1,
      hasMorePages: false,
    );

    when(() => mockProductViewModel.state).thenReturn(loadedState);
    when(() => mockProductViewModel.stream).thenAnswer((_) => Stream.value(loadedState));

    await tester.pumpWidget(_wrapWithBlocAndDummyWishlist(const HomeViewPage()));
    await tester.pumpAndSettle();

    // Both products show initially
    expect(find.text('Apple Watch'), findsOneWidget);
    expect(find.text('Banana Phone'), findsOneWidget);

    // Enter search query to filter for Banana Phone only
    await tester.enterText(find.byType(TextField), 'Banana');
    await tester.pumpAndSettle();

    expect(find.text('Apple Watch'), findsNothing);
    expect(find.text('Banana Phone'), findsOneWidget);
  });

  testWidgets('Tapping Add to Cart icon calls add event on bloc', (tester) async {
    final product = ProductEntity(
      productId: 'p1',
      name: 'Test Product',
      price: 99.99,
      categoryId: 'cat1',
      sellerId: 'seller1',
      filepath: '',
      description: 'Description',
    );

    final loadedState = ProductState(
      isLoading: false,
      isLoadingMore: false,
      isSuccess: true,
      products: [product],
      errorMessage: null,
      currentPage: 1,
      hasMorePages: false,
    );

    when(() => mockProductViewModel.state).thenReturn(loadedState);
    when(() => mockProductViewModel.stream).thenAnswer((_) => Stream.value(loadedState));

    await tester.pumpWidget(_wrapWithBlocAndDummyWishlist(const HomeViewPage()));
    await tester.pumpAndSettle();

    final cartIcon = find.byIcon(Icons.shopping_cart_outlined);
    expect(cartIcon, findsOneWidget);

    await tester.tap(cartIcon);
    await tester.pump();

    verify(() => mockProductViewModel.add(any())).called(1);
  });

  testWidgets('Shows "Please log in first" snackbar when user is null', (tester) async {
    UserSession.instance.userId = null;

    final product = ProductEntity(
      productId: 'p1',
      name: 'Test Product',
      price: 99.99,
      categoryId: 'cat1',
      sellerId: 'seller1',
      filepath: '',
      description: 'Description',
    );

    final loadedState = ProductState(
      isLoading: false,
      isLoadingMore: false,
      isSuccess: true,
      products: [product],
      errorMessage: null,
      currentPage: 1,
      hasMorePages: false,
    );

    when(() => mockProductViewModel.state).thenReturn(loadedState);
    when(() => mockProductViewModel.stream).thenAnswer((_) => Stream.value(loadedState));

    await tester.pumpWidget(_wrapWithBlocAndDummyWishlist(const HomeViewPage()));
    await tester.pumpAndSettle();

    final cartIcon = find.byIcon(Icons.shopping_cart_outlined);
    expect(cartIcon, findsOneWidget);

    await tester.tap(cartIcon);
    await tester.pump();

    expect(find.text('Please log in first'), findsOneWidget);
  });
}
