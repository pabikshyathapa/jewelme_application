import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
import 'package:jewelme_application/core/utils/user_session.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/wishlist/presenttaion/view_model/wishlist_event.dart';
import 'package:jewelme_application/features/wishlist/presenttaion/view_model/wishlist_view_model.dart';


class WishlistButton extends StatefulWidget {
  final ProductEntity product;

  const WishlistButton({Key? key, required this.product}) : super(key: key);

  @override
  State<WishlistButton> createState() => _WishlistButtonState();
}

class _WishlistButtonState extends State<WishlistButton> {
  bool _isInWishlist = false;

  @override
  void initState() {
    super.initState();
    // Optionally initialize _isInWishlist by checking current wishlist state here
  }

  void _toggleWishlist() {
    final currentUserId = UserSession.instance.userId;

    if (currentUserId == null) {
      showMySnackBar(
        context: context,
        message: "Please log in first",
        color: Colors.red,
      );
      return;
    }

    final wishlistViewModel = context.read<WishlistViewModel>();

    if (_isInWishlist) {
      // Remove from wishlist
      wishlistViewModel.add(RemoveWishlistItemEvent(
        context: context,
        userId: currentUserId,
        productId: widget.product.productId,
      ));
    } else {
      // Add to wishlist
      wishlistViewModel.add(AddToWishlistEvent(
        context: context,
        userId: currentUserId,
        product: widget.product,
      ));
    }

    setState(() {
      _isInWishlist = !_isInWishlist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isInWishlist ? Icons.favorite : Icons.favorite_border,
        color: _isInWishlist ? Colors.red : Colors.white,
        size: 20,
      ),
      onPressed: _toggleWishlist,
    );
  }
}
