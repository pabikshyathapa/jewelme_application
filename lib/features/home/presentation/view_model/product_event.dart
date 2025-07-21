import 'package:flutter/material.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

@immutable
sealed class ProductEvent {}

class AddProductEvent extends ProductEvent {
  final BuildContext context;
  final ProductEntity product;

  AddProductEvent({
    required this.context,
    required this.product,
  });
}

class UpdateProductEvent extends ProductEvent {
  final BuildContext context;
  final ProductEntity product;

  UpdateProductEvent({
    required this.context,
    required this.product,
  });
}

class DeleteProductEvent extends ProductEvent {
  final BuildContext context;
  final String productId;

  DeleteProductEvent({
    required this.context,
    required this.productId,
  });
}

class FetchAllProductsEvent extends ProductEvent {
  final int page;
  final int limit;

  FetchAllProductsEvent({this.page = 1, this.limit = 9});
}