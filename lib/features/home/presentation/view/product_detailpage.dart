import 'package:flutter/material.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/core/utils/getimage.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.filepath != null && product.filepath!.isNotEmpty)
              Image.network(
                getBackendImageUrl(product.filepath!),
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text("Price: \$${product.price}", style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text(product.description ?? "No description"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
