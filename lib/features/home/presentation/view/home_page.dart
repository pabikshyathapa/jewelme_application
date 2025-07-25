// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
// import 'package:jewelme_application/core/utils/getimage.dart';
// import 'package:jewelme_application/core/utils/user_session.dart';
// import 'package:jewelme_application/features/cart/presentation/view_model/cart_event.dart';
// import 'package:jewelme_application/features/cart/presentation/view_model/cart_view_model.dart';
// import 'package:jewelme_application/features/home/presentation/view/product_detailpage.dart';
// import 'package:jewelme_application/features/home/presentation/view/wishlist_button.dart';
// import 'package:jewelme_application/features/home/presentation/view_model/product_event.dart';
// import 'package:jewelme_application/features/home/presentation/view_model/product_state.dart';
// import 'package:jewelme_application/features/home/presentation/view_model/product_view_model.dart';
// import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

// class HomeViewPage extends StatefulWidget {
//   const HomeViewPage({Key? key}) : super(key: key);

//   @override
//   State<HomeViewPage> createState() => _HomeViewPageState();
// }

// class _HomeViewPageState extends State<HomeViewPage> {
//   int currentPage = 1;
//   final int limit = 12;

//   @override
//   void initState() {
//     super.initState();
//     context.read<ProductViewModel>().add(
//       FetchAllProductsEvent(page: currentPage, limit: limit),
//     );
//   }

//   void _loadMore() {
//     setState(() {
//       currentPage++;
//     });
//     context.read<ProductViewModel>().add(
//       FetchAllProductsEvent(page: currentPage, limit: limit),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),),
//       body: BlocBuilder<ProductViewModel, ProductState>(
//         builder: (context, state) {
//           if (state.isLoading && state.products.isEmpty) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state.errorMessage != null) {
//             return Center(child: Text('Error: ${state.errorMessage}'));
//           }

//           if (state.products.isEmpty) {
//             return const Center(child: Text('No products found'));
//           }

//           return Column(
//             children: [
//               Expanded(
//                 child: GridView.builder(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 10,
//                   ),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     childAspectRatio: 0.65,
//                   ),
//                   itemCount: state.products.length,
//                   itemBuilder: (context, index) {
//                     final ProductEntity product = state.products[index];
//                     return Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Stack(
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder:
//                                           (_) => ProductDetailPage(
//                                             product: product,
//                                           ),
//                                     ),
//                                   );
//                                 },
//                                 child: ClipRRect(
//                                   borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(15),
//                                   ),
//                                   child:
//                                       (product.filepath != null &&
//                                               product.filepath!.isNotEmpty)
//                                           ? Image.network(
//                                             getBackendImageUrl(
//                                               product.filepath!,
//                                             ),
//                                             width: double.infinity,
//                                             height: 140,
//                                             fit: BoxFit.cover,
//                                             errorBuilder:
//                                                 (context, error, stackTrace) =>
//                                                     const Icon(
//                                                       Icons.image_not_supported,
//                                                       size: 80,
//                                                     ),
//                                           )
//                                           : const Icon(
//                                             Icons.image_not_supported,
//                                             size: 80,
//                                           ),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 2,
//                                 right: 1,
//                                 child: WishlistButton(product: product),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   product.name,
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   "Rs. ${product.price}",
//                                   style: const TextStyle(
//                                     fontSize: 13,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   product.description ?? "",
//                                   style: const TextStyle(fontSize: 12),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.centerRight,
//                                   child: IconButton(
//                                     icon: const Icon(
//                                       Icons.shopping_cart_outlined,
//                                     ),
//                                     iconSize: 20,
//                                     onPressed: () {
//                                       final currentUserId =
//                                           UserSession.instance.userId;

//                                       if (currentUserId != null) {
//                                         context.read<CartViewModel>().add(
//                                           AddToCartEvent(
//                                             context: context,
//                                             userId: currentUserId,
//                                             product: product,
//                                             quantity: 1,
//                                           ),
//                                         );
//                                       } else {
//                                         // Handle case where user is not logged in or userId is missing
//                                         showMySnackBar(
//                                           context: context,
//                                           message: "Please log in first",
//                                           color: Colors.red,
//                                         );
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               if (!state.isLoading && (state.hasMorePages ?? true))
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   child: GestureDetector(
//                     onTap: _loadMore,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Text(
//                           "View More",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.red,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                         SizedBox(width: 4),
//                         Icon(Icons.arrow_forward, size: 18, color: Colors.red),
//                       ],
//                     ),
//                   ),
//                 ),
//               if (state.isLoading && state.products.isNotEmpty)
//                 const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   child: CircularProgressIndicator(),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
import 'package:jewelme_application/core/utils/getimage.dart';
import 'package:jewelme_application/core/utils/user_session.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_event.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:jewelme_application/features/home/presentation/view/product_detailpage.dart';
import 'package:jewelme_application/features/wishlist/presenttaion/view/wishlist_button.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_event.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_state.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_view_model.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({Key? key}) : super(key: key);

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  int currentPage = 1;
  final int limit = 12;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() {
    context.read<ProductViewModel>().add(
          FetchAllProductsEvent(page: currentPage, limit: limit),
        );
  }

  void _loadMore() {
    setState(() {
      currentPage++;
    });
    _fetchProducts();
  }

  List<ProductEntity> _filterProducts(List<ProductEntity> products) {
    if (searchQuery.isEmpty) return products;
    return products
        .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductViewModel, ProductState>(
              builder: (context, state) {
                if (state.isLoading && state.products.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.errorMessage != null) {
                  return Center(child: Text('Error: ${state.errorMessage}'));
                }

                final filteredProducts = _filterProducts(state.products);

                if (filteredProducts.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                return Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                ProductDetailPage(product: product),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(15),
                                        ),
                                        child: (product.filepath != null &&
                                                product.filepath!.isNotEmpty)
                                            ? Image.network(
                                                getBackendImageUrl(product.filepath!),
                                                width: double.infinity,
                                                height: 140,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (context, error, stackTrace) =>
                                                        const Icon(
                                                  Icons.image_not_supported,
                                                  size: 80,
                                                ),
                                              )
                                            : const Icon(
                                                Icons.image_not_supported,
                                                size: 80,
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 2,
                                      right: 1,
                                      child: WishlistButton(product: product),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Rs. ${product.price}",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        product.description ?? "",
                                        style: const TextStyle(fontSize: 12),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.shopping_cart_outlined,
                                            color: Color(0xFFD9534F),
                                          ),
                                          iconSize: 20,
                                          onPressed: () {
                                            final currentUserId =
                                                UserSession.instance.userId;
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    if (!state.isLoading && (state.hasMorePages ?? true))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                          onTap: _loadMore,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "View More",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward, size: 18, color: Colors.red),
                            ],
                          ),
                        ),
                      ),
                    if (state.isLoading && state.products.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
