import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/core/utils/getimage.dart';
import 'package:jewelme_application/core/utils/user_session.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_event.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_state.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:jewelme_application/features/order/presenttaion/view/order_page.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_event.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_state.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_view_model.dart';

class CartViewPage extends StatefulWidget {
  const CartViewPage({Key? key}) : super(key: key);

  @override
  State<CartViewPage> createState() => _CartViewPageState();
}

class _CartViewPageState extends State<CartViewPage> {
  @override
  void initState() {
    super.initState();
    final userId = UserSession.instance.userId;
    if (userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<CartViewModel>().add(
          FetchCartEvent(userId: userId, context: context),
        );
      });
    }
  }

  double calculateTotal(List<dynamic> cartItems) {
    double total = 0;
    for (var item in cartItems) {
      total += (item.price * item.quantity);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final String? userId = UserSession.instance.userId;

    if (userId == null) {
      return const Scaffold(body: Center(child: Text('User not logged in')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),),
      body: MultiBlocListener(
        listeners: [
          BlocListener<OrderViewModel, OrderState>(
            listener: (context, state) {
              if (state.isSuccess && state.lastOrder != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderConfirmationPage(order: state.lastOrder!),
                  ),
                );
              }
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<CartViewModel, CartState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!state.isSuccess && state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            }

            final cartItems = state.cartItems ?? [];

            if (cartItems.isEmpty) {
              return const Center(child: Text('Your cart is empty.'));
            }

            final totalAmount = calculateTotal(cartItems);

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  getBackendImageUrl(product.filepath),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text("Price: Rs.${product.price.toStringAsFixed(2)}"),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: product.quantity > 1
                                              ? () {
                                                  final updatedProduct = product.copyWith(
                                                    quantity: product.quantity - 1,
                                                  );
                                                  context.read<CartViewModel>().add(
                                                        UpdateCartItemQuantityEvent(
                                                          context: context,
                                                          userId: userId,
                                                          productId: updatedProduct.productId,
                                                          quantity: updatedProduct.quantity,
                                                        ),
                                                      );
                                                }
                                              : null,
                                        ),
                                        Text('${product.quantity}'),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            final updatedProduct = product.copyWith(
                                              quantity: product.quantity + 1,
                                            );
                                            context.read<CartViewModel>().add(
                                                  UpdateCartItemQuantityEvent(
                                                    context: context,
                                                    userId: userId,
                                                    productId: updatedProduct.productId,
                                                    quantity: updatedProduct.quantity,
                                                  ),
                                                );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  context.read<CartViewModel>().add(
                                        RemoveCartItemEvent(
                                          context: context,
                                          userId: userId,
                                          productId: product.productId,
                                        ),
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// 🔽 Total + Checkout
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.4), blurRadius: 6),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Rs. ${totalAmount.toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<OrderViewModel>().add(
                              CheckoutCartEvent(
                                userId: userId,
                                context: context,
                              ),
                            );
                          },
                          child: const Text("Checkout"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


