import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
import 'package:jewelme_application/core/utils/getimage.dart';
import 'package:jewelme_application/core/utils/user_session.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_event.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:jewelme_application/features/wishlist/presenttaion/view_model/wishlist_event.dart';
import 'package:jewelme_application/features/wishlist/presenttaion/view_model/wishlist_state.dart';
import 'package:jewelme_application/features/wishlist/presenttaion/view_model/wishlist_view_model.dart';

class WishlistViewPage extends StatefulWidget {
  const WishlistViewPage({Key? key}) : super(key: key);

  @override
  State<WishlistViewPage> createState() => _WishlistViewPageState();
}

class _WishlistViewPageState extends State<WishlistViewPage> {
  @override
  void initState() {
    super.initState();
    final userId = UserSession.instance.userId;
    if (userId != null) {
      // Fetch wishlist items on page load
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<WishlistViewModel>().add(
          FetchWishlistEvent(userId: userId, context: context),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? userId = UserSession.instance.userId;

    if (userId == null) {
      return const Scaffold(body: Center(child: Text('User not logged in')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Wishlist')),
      body: BlocBuilder<WishlistViewModel, WishlistState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!state.isSuccess && state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }

          final wishlistItems = state.wishlistItems ?? [];

          if (wishlistItems.isEmpty) {
            return const Center(child: Text('Your wishlist is empty.'));
          }

          return ListView.builder(
            itemCount: wishlistItems.length,
            itemBuilder: (context, index) {
              final product = wishlistItems[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Product image
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

                      // Product details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text("Rs. ${product.price.toStringAsFixed(2)}"),
                            const SizedBox(height: 4),
                            Text(
                              product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Add to Cart button
                      IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          final productEntity = product.toProductEntity();

                          // Add to cart
                          context.read<CartViewModel>().add(
                            AddToCartEvent(
                              context: context,
                              userId: userId,
                              product: productEntity,
                              quantity: 1,
                            ),
                          );

                          // Remove from wishlist
                          context.read<WishlistViewModel>().add(
                            RemoveWishlistItemEvent(
                              userId: userId,
                              productId: product.productId,
                              context: context, // or productEntity.id
                            ),
                          );

                          // Show snackbar
                          showMySnackBar(
                            context: context,
                            message: 'Added to cart!',
                          );
                        },
                      ),

                      // Remove from wishlist button (filled heart)
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          context.read<WishlistViewModel>().add(
                            RemoveWishlistItemEvent(
                              context: context,
                              userId: userId,
                              productId: product.productId,
                            ),
                          );
                          showMySnackBar(
                            context: context,
                            message: 'Removed from wishlist',
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
