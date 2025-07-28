// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jewelme_application/core/utils/getimage.dart';
// import 'package:jewelme_application/core/utils/user_session.dart';
// import 'package:jewelme_application/features/cart/presentation/view_model/cart_event.dart';
// import 'package:jewelme_application/features/cart/presentation/view_model/cart_state.dart';
// import 'package:jewelme_application/features/cart/presentation/view_model/cart_view_model.dart';
// import 'package:jewelme_application/features/order/presenttaion/view/order_page.dart';
// import 'package:jewelme_application/features/order/presenttaion/view_model/order_event.dart';
// import 'package:jewelme_application/features/order/presenttaion/view_model/order_state.dart';
// import 'package:jewelme_application/features/order/presenttaion/view_model/order_view_model.dart';

// class CartViewPage extends StatefulWidget {
//   const CartViewPage({Key? key}) : super(key: key);

//   @override
//   State<CartViewPage> createState() => _CartViewPageState();
// }

// class _CartViewPageState extends State<CartViewPage> {
//   @override
//   void initState() {
//     super.initState();
//     final userId = UserSession.instance.userId;
//     if (userId != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         context.read<CartViewModel>().add(FetchCartEvent(userId: userId, context: context));
//       });
//     }
//   }

//   double calculateTotal(List<dynamic> cartItems) {
//     return cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String? userId = UserSession.instance.userId;

//     if (userId == null) {
//       return const Scaffold(body: Center(child: Text('User not logged in')));
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Cart'),
//         centerTitle: true,
//       ),
//       body: MultiBlocListener(
//         listeners: [
//           BlocListener<OrderViewModel, OrderState>(
//             listener: (context, state) {
//               if (state.isSuccess && state.lastOrder != null) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => OrderConfirmationPage(order: state.lastOrder!),
//                   ),
//                 );
//               } else if (state.errorMessage != null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(state.errorMessage!), backgroundColor: Colors.red),
//                 );
//               }
//             },
//           ),
//         ],
//         child: BlocBuilder<CartViewModel, CartState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (!state.isSuccess && state.errorMessage != null) {
//               return Center(child: Text(state.errorMessage!));
//             }

//             final cartItems = state.cartItems ?? [];
//             if (cartItems.isEmpty) {
//               return const Center(child: Text('Your cart is empty.'));
//             }

//             final totalAmount = calculateTotal(cartItems);

//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.all(12),
//                     itemCount: cartItems.length,
//                     itemBuilder: (context, index) {
//                       final product = cartItems[index];
//                       return Container(
//                         margin: const EdgeInsets.symmetric(vertical: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               blurRadius: 6,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 bottomLeft: Radius.circular(12),
//                               ),
//                               child: Image.network(
//                                 getBackendImageUrl(product.filepath),
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (_, __, ___) =>
//                                     const Icon(Icons.broken_image, size: 80, color: Colors.grey),
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       product.name,
//                                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                     ),
//                                     const SizedBox(height: 6),
//                                     Text("Price: Rs.${product.price.toStringAsFixed(2)}"),
//                                     const SizedBox(height: 8),
//                                     Row(
//                                       children: [
//                                         IconButton(
//                                           icon: const Icon(Icons.remove_circle_outline),
//                                           onPressed: product.quantity > 1
//                                               ? () {
//                                                   context.read<CartViewModel>().add(
//                                                         UpdateCartItemQuantityEvent(
//                                                           context: context,
//                                                           userId: userId,
//                                                           productId: product.productId,
//                                                           quantity: product.quantity - 1,
//                                                         ),
//                                                       );
//                                                 }
//                                               : null,
//                                         ),
//                                         Text('${product.quantity}',
//                                             style: const TextStyle(fontSize: 16)),
//                                         IconButton(
//                                           icon: const Icon(Icons.add_circle_outline),
//                                           onPressed: () {
//                                             context.read<CartViewModel>().add(
//                                                   UpdateCartItemQuantityEvent(
//                                                     context: context,
//                                                     userId: userId,
//                                                     productId: product.productId,
//                                                     quantity: product.quantity + 1,
//                                                   ),
//                                                 );
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
//                               onPressed: () {
//                                 context.read<CartViewModel>().add(
//                                       RemoveCartItemEvent(
//                                         context: context,
//                                         userId: userId,
//                                         productId: product.productId,
//                                       ),
//                                     );
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 // 🔽 Checkout Section
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, -1)),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                           Text("Rs. ${totalAmount.toStringAsFixed(2)}",
//                               style: const TextStyle(fontSize: 18, color: Colors.redAccent, fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 55,
//                         child: ElevatedButton.icon(
//                           icon: const Icon(Icons.shopping_bag),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                           ),
//                           onPressed: () {
//                             context.read<OrderViewModel>().add(
//                                   CheckoutCartEvent(userId: userId, context: context),
//                                 );
//                           },
//                           label: const Text("Checkout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  bool _hasTilted = false;

  @override
  void initState() {
    super.initState();
    final userId = UserSession.instance.userId;
    if (userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<CartViewModel>().add(FetchCartEvent(userId: userId, context: context));
      });
    }

    // 👇 Gyroscope logic
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      if (!_hasTilted && event.y.abs() > 2.5) {
        _hasTilted = true;

        final userId = UserSession.instance.userId;
        if (userId != null) {
          context.read<OrderViewModel>().add(
                CheckoutCartEvent(userId: userId, context: context),
              );
        }

        // Reset flag after short delay
        Future.delayed(const Duration(seconds: 2), () {
          _hasTilted = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  double calculateTotal(List<dynamic> cartItems) {
    return cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    final String? userId = UserSession.instance.userId;

    if (userId == null) {
      return const Scaffold(body: Center(child: Text('User not logged in')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
      ),
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
              } else if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!), backgroundColor: Colors.red),
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
                    padding: const EdgeInsets.all(12),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              child: Image.network(
                                getBackendImageUrl(product.filepath),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 6),
                                    Text("Price: Rs.${product.price.toStringAsFixed(2)}"),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove_circle_outline),
                                          onPressed: product.quantity > 1
                                              ? () {
                                                  context.read<CartViewModel>().add(
                                                        UpdateCartItemQuantityEvent(
                                                          context: context,
                                                          userId: userId,
                                                          productId: product.productId,
                                                          quantity: product.quantity - 1,
                                                        ),
                                                      );
                                                }
                                              : null,
                                        ),
                                        Text('${product.quantity}',
                                            style: const TextStyle(fontSize: 16)),
                                        IconButton(
                                          icon: const Icon(Icons.add_circle_outline),
                                          onPressed: () {
                                            context.read<CartViewModel>().add(
                                                  UpdateCartItemQuantityEvent(
                                                    context: context,
                                                    userId: userId,
                                                    productId: product.productId,
                                                    quantity: product.quantity + 1,
                                                  ),
                                                );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
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
                      );
                    },
                  ),
                ),

                // 🔽 Checkout Section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, -1)),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                          Text("Rs. ${totalAmount.toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 18, color: Colors.redAccent, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.shopping_bag),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            context.read<OrderViewModel>().add(
                                  CheckoutCartEvent(userId: userId, context: context),
                                );
                          },
                          label: const Text("Checkout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tilt your phone right to checkout',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
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
