import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/profile/presenttaion/view/profile_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';
import 'package:jewelme_application/features/order/domain/entity/order_item_entity.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_state.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_view_model.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/profile/presenttaion/view_model/user_state.dart';
import 'package:jewelme_application/features/profile/presenttaion/view_model/user_view_model.dart';

// Mock classes
class MockUserViewModel extends Mock implements UserViewModel {}

class MockOrderViewModel extends Mock implements OrderViewModel {}

// Fake classes for events and states
class FakeUserEvent extends Fake {}

class FakeUserState extends Fake implements UserState {}

class FakeOrderEvent extends Fake {}

class FakeOrderState extends Fake implements OrderState {}

void main() {
  late MockUserViewModel mockUserViewModel;
  late MockOrderViewModel mockOrderViewModel;

  setUpAll(() {
    registerFallbackValue(FakeUserEvent());
    registerFallbackValue(FakeUserState());
    registerFallbackValue(FakeOrderEvent());
    registerFallbackValue(FakeOrderState());
  });

  setUp(() {
    mockUserViewModel = MockUserViewModel();
    mockOrderViewModel = MockOrderViewModel();

    // Mock UserViewModel initial state
    when(() => mockUserViewModel.state).thenReturn(
      UserState(
        isLoading: false,
        user: const UserEntity(
          id: 'user1',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '1234567890',
        ),
        errorMessage: null,
        isSuccess: false,
      ),
    );
    when(() => mockUserViewModel.stream).thenAnswer(
      (_) => Stream.value(
        UserState(
          isLoading: false,
          user: const UserEntity(
            id: 'user1',
            name: 'John Doe',
            email: 'john@example.com',
            phone: '1234567890',
          ),
          errorMessage: null,
          isSuccess: false,
        ),
      ),
    );

    // Mock OrderViewModel initial state
    when(() => mockOrderViewModel.state).thenReturn(
      OrderState(
        isLoading: false,
        orders: [
          OrderEntity(
            id: 'order1',
            userId: 'user1',
            totalAmount: 1000,
            createdAt: DateTime(2025, 7, 25),
            products: [
              const OrderItemEntity(
                productId: 'p1',
                name: 'Product 1',
                price: 500,
                quantity: 1,
                filepath: '',
              ),
              const OrderItemEntity(
                productId: 'p2',
                name: 'Product 2',
                price: 500,
                quantity: 1,
                filepath: '',
              ),
            ],
          ),
        ],
        errorMessage: null,
        isSuccess: false,
      ),
    );
    when(() => mockOrderViewModel.stream).thenAnswer(
      (_) => Stream.value(
        OrderState(
          isLoading: false,
          orders: [
            OrderEntity(
              id: 'order1',
              userId: 'user1',
              totalAmount: 1000,
              createdAt: DateTime(2025, 7, 25),
              products: [
                const OrderItemEntity(
                  productId: 'p1',
                  name: 'Product 1',
                  price: 500,
                  quantity: 1,
                  filepath: '',
                ),
                const OrderItemEntity(
                  productId: 'p2',
                  name: 'Product 2',
                  price: 500,
                  quantity: 1,
                  filepath: '',
                ),
              ],
            ),
          ],
          errorMessage: null,
          isSuccess: false,
        ),
      ),
    );
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: Scaffold(  // <-- Add Scaffold here so SnackBar works
        body: MultiBlocProvider(
          providers: [
            BlocProvider<UserViewModel>.value(value: mockUserViewModel),
            BlocProvider<OrderViewModel>.value(value: mockOrderViewModel),
          ],
          child: const ProfilePage(),
        ),
      ),
    );
  }

  testWidgets('Displays user info and orders correctly', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Verify user info in TextFields
    expect(find.widgetWithText(TextField, 'Name'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Phone'), findsOneWidget);

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('john@example.com'), findsOneWidget);
    expect(find.text('1234567890'), findsOneWidget);

    // Verify orders section
    expect(find.text('My Orders'), findsOneWidget);
    expect(find.text('Order ID: order1'), findsOneWidget);
    expect(find.text('Total: Rs 1000.00'), findsOneWidget);
    expect(find.text('Product 1'), findsOneWidget);
    expect(find.text('Product 2'), findsOneWidget);
  });

 testWidgets('Shows loading indicator when userState.isLoading is true', (tester) async {
  when(() => mockUserViewModel.state).thenReturn(UserState(isLoading: true, isSuccess: false));
  when(() => mockUserViewModel.stream).thenAnswer((_) => Stream.value(UserState(isLoading: true, isSuccess: false)));

  await tester.pumpWidget(createTestWidget());
  await tester.pump(); // Build first frame

  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});

testWidgets('Shows no user data message if user is null', (tester) async {
  when(() => mockUserViewModel.state).thenReturn(UserState(isLoading: false, user: null, isSuccess: false));
  when(() => mockUserViewModel.stream).thenAnswer((_) => Stream.value(UserState(isLoading: false, user: null, isSuccess:false)));

  await tester.pumpWidget(createTestWidget());
  await tester.pump();

  expect(find.text('No user data available.'), findsOneWidget);
});

testWidgets('Shows error SnackBar if userState.errorMessage is not null', (tester) async {
  when(() => mockUserViewModel.state).thenReturn(
    UserState(isLoading: false, errorMessage: 'Error occurred', isSuccess: false),
  );
  when(() => mockUserViewModel.stream).thenAnswer(
    (_) => Stream.value(UserState(isLoading: false, errorMessage: 'Error occurred', isSuccess: false)),
  );

  await tester.pumpWidget(createTestWidget());
  await tester.pump(); // build frame with error
  await tester.pump(const Duration(seconds: 1)); // wait SnackBar animation

  expect(find.byType(SnackBar), findsOneWidget);
  expect(find.text('Error occurred'), findsOneWidget);
});
}
