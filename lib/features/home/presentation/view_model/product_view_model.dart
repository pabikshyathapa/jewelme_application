import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';
import 'package:jewelme_application/features/home/domain/use_case/delete_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/fetchall_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/product_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/update_usecase.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_event.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_state.dart';

class ProductViewModel extends Bloc<ProductEvent, ProductState> {
  final AddProductUsecase _addProductUsecase;
  final UpdateProductUsecase _updateProductUsecase;
  final DeleteProductUsecase _deleteProductUsecase;
  final FetchAllProductsUsecase _fetchAllProductsUsecase;

  ProductViewModel({
    required AddProductUsecase addProductUsecase,
    required UpdateProductUsecase updateProductUsecase,
    required DeleteProductUsecase deleteProductUsecase,
    required FetchAllProductsUsecase fetchAllProductsUsecase,
  })  : _addProductUsecase = addProductUsecase,
        _updateProductUsecase = updateProductUsecase,
        _deleteProductUsecase = deleteProductUsecase,
        _fetchAllProductsUsecase = fetchAllProductsUsecase,
        super(const ProductState.initial()) {
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<FetchAllProductsEvent>(_onFetchAllProducts);
  }

  Future<void> _onAddProduct(AddProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    final params = AddProductUseParams(
      name: event.product.name,
      categoryId: event.product.categoryId,
      sellerId: event.product.sellerId,
      price: event.product.price,
      filepath: event.product.filepath ?? '',
      description: event.product.description ?? '',
      stock: event.product.stock ?? 0,
    );
    final result = await _addProductUsecase.call(params);
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(content: Text('Failed to add product: ${failure.message}')),
        );
      },
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );
        add(FetchAllProductsEvent()); // Refresh list after add
      },
    );
  }

  Future<void> _onUpdateProduct(UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    final result = await _updateProductUsecase.call(event.product);
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(content: Text('Failed to update product: ${failure.message}')),
        );
      },
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(content: Text('Product updated successfully')),
        );
        add(FetchAllProductsEvent()); // Refresh list after update
      },
    );
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    final result = await _deleteProductUsecase.call(event.productId);
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(content: Text('Failed to delete product: ${failure.message}')),
        );
      },
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(content: Text('Product deleted successfully')),
        );
        add(FetchAllProductsEvent()); // Refresh list after delete
      },
    );
  }

 Future<void> _onFetchAllProducts(FetchAllProductsEvent event, Emitter<ProductState> emit) async {
  final isFirstPage = event.page == 1;

  emit(state.copyWith(
    isLoading: isFirstPage,
    isLoadingMore: !isFirstPage,
    errorMessage: null,
  ));

  final result = await _fetchAllProductsUsecase.call(page: event.page, limit: event.limit);

  result.fold(
    (failure) {
      emit(state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        errorMessage: failure.message,
        products: isFirstPage ? [] : state.products,
      ));
    },
    (newProducts) {
      final allProducts = isFirstPage ? newProducts : [...state.products, ...newProducts];

      // If fewer products than limit are returned, no more pages
      final bool hasMorePages = newProducts.length == event.limit;

      emit(state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        products: allProducts,
        errorMessage: null,
        currentPage: event.page,
        hasMorePages: hasMorePages,
      ));
    },
  );
}
}