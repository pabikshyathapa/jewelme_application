import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
import 'package:jewelme_application/core/utils/getimage.dart';
import 'package:jewelme_application/core/utils/user_session.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_event.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/wishlist/presenttaion/view/wishlist_button.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.filepath != null && product.filepath!.isNotEmpty
        ? getBackendImageUrl(product.filepath!)
        : null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white70,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: WishlistButton(product: product),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image
            Stack(
              children: [
                if (imageUrl != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                  )
                else
                  const SizedBox(
                    height: 350,
                    child: Center(
                      child: Icon(Icons.image_not_supported,
                          size: 80, color: Colors.grey),
                    ),
                  ),
              ],
            ),

            // Product Info Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Price: Rs.${product.price}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFD9534F),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      product.description ?? "No description available.",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Add to Cart Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final currentUserId = UserSession.instance.userId;
                    if (currentUserId != null) {
                      context.read<CartViewModel>().add(
                            AddToCartEvent(
                              context: context,
                              userId: currentUserId,
                              product: product,
                              quantity: 1,
                            ),
                          );
                    } else {
                      showMySnackBar(
                        context: context,
                        message: "Please log in first",
                        color: Colors.red,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD9534F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.shopping_cart_outlined, size: 22),
                  label: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF8F8F8),
    );
  }
}
