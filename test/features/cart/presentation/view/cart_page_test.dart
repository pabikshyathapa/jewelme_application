import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/cart/presentation/view/cart_page.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_event.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_state.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:jewelme_application/features/cart/domain/entity/cart_item_entity.dart';

import 'package:jewelme_application/features/order/presenttaion/view_model/order_event.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_state.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_view_model.dart';

import 'package:jewelme_application/core/utils/user_session.dart';

import 'package:mocktail/mocktail.dart';

// Mock Classes
class MockCartViewModel extends Mock implements CartViewModel {}
class MockOrderViewModel extends Mock implements OrderViewModel {}

// Fake Classes (do NOT extend sealed classes)
class FakeCartEvent extends Fake {}
class FakeCartState extends Fake implements CartState {}
class FakeOrderEvent extends Fake {}
class FakeOrderState extends Fake implements OrderState {}

void main() {
  late MockCartViewModel mockCartBloc;
  late MockOrderViewModel mockOrderBloc;

  setUpAll(() {
    registerFallbackValue(FakeCartEvent());
    registerFallbackValue(FakeCartState());
    registerFallbackValue(FakeOrderEvent());
    registerFallbackValue(FakeOrderState());
  });

  setUp(() {
    mockCartBloc = MockCartViewModel();
    mockOrderBloc = MockOrderViewModel();

    // Cart initial state
    when(() => mockCartBloc.state).thenReturn(
      const CartState(
        isLoading: false,
        isSuccess: true,
        cartItems: [],
        errorMessage: null,
      ),
    );

    // Order initial state - make sure non-null
    when(() => mockOrderBloc.state).thenReturn(
      OrderState.initial(),
    );

    when(() => mockCartBloc.stream).thenAnswer((_) => Stream.value(mockCartBloc.state));
    when(() => mockOrderBloc.stream).thenAnswer((_) => Stream.value(mockOrderBloc.state));
  });

  // Override Image.network to avoid network calls during tests
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Replace network images with a placeholder
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  });

  Widget createTestWidget() {
    // Simulate logged-in user
    UserSession.instance.userId = 'user123';

    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CartViewModel>.value(value: mockCartBloc),
          BlocProvider<OrderViewModel>.value(value: mockOrderBloc),
        ],
        child: const CartViewPage(),
      ),
    );
  }

  testWidgets('Shows loading indicator when loading', (tester) async {
    when(() => mockCartBloc.state).thenReturn(
      const CartState(
        isLoading: true,
        isSuccess: false,
        cartItems: [],
      ),
    );
    when(() => mockCartBloc.stream).thenAnswer((_) => Stream.value(mockCartBloc.state));

    await tester.pumpWidget(createTestWidget());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Shows error message on failure', (tester) async {
    when(() => mockCartBloc.state).thenReturn(
      const CartState(
        isLoading: false,
        isSuccess: false,
        errorMessage: 'Failed to load cart',
        cartItems: [],
      ),
    );
    when(() => mockCartBloc.stream).thenAnswer((_) => Stream.value(mockCartBloc.state));

    await tester.pumpWidget(createTestWidget());
    await tester.pump();

    expect(find.text('Failed to load cart'), findsOneWidget);
  });

  testWidgets('Shows empty cart message when cartItems is empty', (tester) async {
    when(() => mockCartBloc.state).thenReturn(
      const CartState(
        isLoading: false,
        isSuccess: true,
        cartItems: [],
      ),
    );
    when(() => mockCartBloc.stream).thenAnswer((_) => Stream.value(mockCartBloc.state));

    await tester.pumpWidget(createTestWidget());
    await tester.pump();

    expect(find.text('Your cart is empty.'), findsOneWidget);
  });

  testWidgets('Displays cart items and responds to quantity changes and removal', (tester) async {
    final cartItem = CartItemEntity(
      productId: 'prod1',
      name: 'Test Product',
      price: 50,
      quantity: 2,
      filepath: 'test.png',
    );

    when(() => mockCartBloc.state).thenReturn(
      CartState(
        isLoading: false,
        isSuccess: true,
        cartItems: [cartItem],
      ),
    );
    when(() => mockCartBloc.stream).thenAnswer((_) => Stream.value(mockCartBloc.state));

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('Price: Rs.50.00'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);

    final addButton = find.widgetWithIcon(IconButton, Icons.add);
    await tester.tap(addButton);
    await tester.pump();

    verify(() => mockCartBloc.add(any(that: isA<UpdateCartItemQuantityEvent>()))).called(1);

    final removeButton = find.widgetWithIcon(IconButton, Icons.remove);
    await tester.tap(removeButton);
    await tester.pump();

    verify(() => mockCartBloc.add(any(that: isA<UpdateCartItemQuantityEvent>()))).called(1);

    final deleteButton = find.widgetWithIcon(IconButton, Icons.delete);
    await tester.tap(deleteButton);
    await tester.pump();

    verify(() => mockCartBloc.add(any(that: isA<RemoveCartItemEvent>()))).called(1);
  });

  testWidgets('Tapping Checkout button triggers CheckoutCartEvent', (tester) async {
    final cartItem = CartItemEntity(
      productId: 'prod1',
      name: 'Test Product',
      price: 50,
      quantity: 1,
      filepath: 'test.png',
    );

    when(() => mockCartBloc.state).thenReturn(
      CartState(
        isLoading: false,
        isSuccess: true,
        cartItems: [cartItem],
      ),
    );
    when(() => mockCartBloc.stream).thenAnswer((_) => Stream.value(mockCartBloc.state));

    when(() => mockOrderBloc.state).thenReturn(OrderState.initial());
    when(() => mockOrderBloc.stream).thenAnswer((_) => Stream.value(mockOrderBloc.state));

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    final checkoutButton = find.widgetWithText(ElevatedButton, 'Checkout');
    expect(checkoutButton, findsOneWidget);

    await tester.tap(checkoutButton);
    await tester.pump();

    verify(() => mockOrderBloc.add(any(that: isA<CheckoutCartEvent>()))).called(1);
  });

  testWidgets('Shows user not logged in message when userId is null', (tester) async {
    UserSession.instance.userId = null;

    await tester.pumpWidget(createTestWidget());
    await tester.pump();

    expect(find.text('User not logged in'), findsOneWidget);
  });
}
