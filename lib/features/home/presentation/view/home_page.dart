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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black87,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar with soft shadow and rounded corners
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(18),
                shadowColor: Colors.black12,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
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

                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification.metrics.pixels ==
                              scrollNotification.metrics.maxScrollExtent &&
                          !state.isLoading &&
                          (state.hasMorePages ?? true)) {
                        _loadMore();
                        return true;
                      }
                      return false;
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final product = filteredProducts[index];
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Card(
                                    elevation: 5,
                                    shadowColor: Colors.black26,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Stack(
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
                                                    top: Radius.circular(20),
                                                  ),
                                                  child: (product.filepath != null &&
                                                          product.filepath!.isNotEmpty)
                                                      ? Image.network(
                                                          getBackendImageUrl(product.filepath!),
                                                          width: double.infinity,
                                                          height: double.infinity,
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context, error, stackTrace) =>
                                                              const Icon(Icons.image_not_supported,
                                                                  size: 80, color: Colors.grey),
                                                        )
                                                      : const Icon(Icons.image_not_supported,
                                                          size: 80, color: Colors.grey),
                                                ),
                                              ),
                                              Positioned(
                                                top: 8,
                                                right: 8,
                                                child: WishlistButton(product: product),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                "Rs. ${product.price}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFFD9534F),
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                product.description ?? "",
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF555555),
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 8),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFD9534F).withOpacity(0.12),
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.shopping_cart_outlined,
                                                      color: Color(0xFFD9534F),
                                                    ),
                                                    iconSize: 22,
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
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: filteredProducts.length,
                            ),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.65,
                            ),
                          ),
                        ),
                        if (state.isLoading && state.products.isNotEmpty)
                          const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        // View More button with soft underline and arrow from previous version
                        if (!state.isLoading && (state.hasMorePages ?? true))
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
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
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Icon(Icons.arrow_forward, size: 18, color: Colors.red),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
