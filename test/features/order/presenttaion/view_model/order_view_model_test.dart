import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/order/domain/use_case/checkout_usecase.dart';
import 'package:jewelme_application/features/order/domain/use_case/get_userby_id_usecase.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_event.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_view_model.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckoutUseCase extends Mock implements CheckoutCartUsecase {}

class MockGetOrdersUseCase extends Mock implements GetOrdersByUserUsecase {}

class FakeCheckoutParams extends Fake implements CheckoutCartUseParams {}

void main() {
  late MockCheckoutUseCase mockCheckoutUseCase;
  late MockGetOrdersUseCase mockGetOrdersUseCase;

  setUpAll(() {
    registerFallbackValue(FakeCheckoutParams());
  });

  setUp(() {
    mockCheckoutUseCase = MockCheckoutUseCase();
    mockGetOrdersUseCase = MockGetOrdersUseCase();
  });

  testWidgets('OrderViewModel emits loading and success, shows checkout snackbar', (tester) async {
    // Arrange: Mock success response from checkout use case
    final testOrder = OrderEntity(
  id: '1',
  userId: 'user1',
  totalAmount: 100.0,
  products: [],
  createdAt: DateTime.now(),
);
    when(() => mockCheckoutUseCase.call(any()))
        .thenAnswer((_) async => Right(testOrder));

    final viewModel = OrderViewModel(
      checkoutCartUsecase: mockCheckoutUseCase,
      getOrdersByUserUsecase: mockGetOrdersUseCase,
    );

    // Build minimal test UI with button to trigger CheckoutCartEvent
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: viewModel,
            child: Builder(
              builder: (context) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<OrderViewModel>().add(
                            CheckoutCartEvent(
                              userId: 'user1',
                              context: context,
                            ),
                          );
                    },
                    child: const Text('Checkout'),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    // Act: Tap the Checkout button
    await tester.tap(find.text('Checkout'));
    await tester.pump(); // Let bloc emit loading
    await tester.pump(const Duration(seconds: 1)); // Let snackbar appear

    // Assert
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Checkout successful!'), findsOneWidget);
  });
}
