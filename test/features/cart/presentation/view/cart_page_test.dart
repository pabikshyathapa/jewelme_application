import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/cart/presentation/view/cart_page.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_state.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_view_model.dart';
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
}
