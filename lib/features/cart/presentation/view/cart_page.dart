import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/core/utils/getimage.dart';
import 'package:jewelme_application/core/utils/user_session.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_event.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_state.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_view_model.dart';

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
      // Dispatch fetch cart event once when the page loads
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<CartViewModel>().add(FetchCartEvent(userId: userId, context: context));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? userId = UserSession.instance.userId;

    if (userId == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not logged in'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: BlocBuilder<CartViewModel, CartState>(
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

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems[index];

              int quantity = product.quantity;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    getBackendImageUrl(product.filepath),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Price: \$${product.price.toStringAsFixed(2)}"),
                      Text("Quantity: $quantity"),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: quantity > 1
                                ? () {
                                    context.read<CartViewModel>().add(
                                          UpdateCartItemQuantityEvent(
                                            context: context,
                                            userId: userId,
                                            productId: product.productId,
                                            quantity: quantity - 1,
                                          ),
                                        );
                                  }
                                : null,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              context.read<CartViewModel>().add(
                                    UpdateCartItemQuantityEvent(
                                      context: context,
                                      userId: userId,
                                      productId: product.productId,
                                      quantity: quantity + 1,
                                    ),
                                  );
                            },
                          ),
                        ],
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
          );
        },
      ),
    );
  }
}
