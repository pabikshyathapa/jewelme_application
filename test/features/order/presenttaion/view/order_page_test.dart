import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';
import 'package:jewelme_application/features/order/domain/entity/order_item_entity.dart';
import 'package:jewelme_application/features/order/presenttaion/view/order_page.dart';

void main() {
  final testOrder = OrderEntity(
    id: "ORD123",
    userId: "user1",
    products: [
      OrderItemEntity(
        productId: "p1",
        name: "Diamond Ring",
        quantity: 1,
        price: 50000,
        filepath: "https://example.com/images/diamond_ring.png",
      ),
      OrderItemEntity(
        productId: "p2",
        name: "Gold Necklace",
        quantity: 2,
        price: 120000,
        filepath: "", // empty path to test fallback icon
      ),
    ],
    totalAmount: 290000,
    createdAt: DateTime(2025, 7, 25),
  );

  testWidgets('OrderConfirmationPage displays order details correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: OrderConfirmationPage(order: testOrder),
      ),
    );

    // Verify order header
    expect(find.text('Order ID: ORD123'), findsOneWidget);
    expect(find.text('Date: July 25, 2025'), findsOneWidget);

    // Verify products details
    expect(find.text('Diamond Ring'), findsOneWidget);
    expect(find.text('Quantity: 1'), findsOneWidget);
    expect(find.text('Rs. 50000.00'), findsOneWidget);

    expect(find.text('Gold Necklace'), findsOneWidget);
    expect(find.text('Quantity: 2'), findsOneWidget);
    expect(find.text('Rs. 120000.00'), findsOneWidget);

    // Verify total amount
    expect(find.text('Total: '), findsOneWidget);
    expect(find.text('Rs. 290000.00'), findsOneWidget);

    // Verify image loaded for first product
    expect(find.byType(Image), findsOneWidget);

    // Verify fallback icon for second product (empty filepath)
    expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
  });
}
