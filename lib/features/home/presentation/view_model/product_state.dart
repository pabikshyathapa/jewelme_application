import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/home/domain/entity/product_entity.dart';

class ProductState extends Equatable {
  final bool isLoading;        // loading first page
  final bool isLoadingMore;    // loading next page(s)
  final bool isSuccess;
  final String? selectedImageName;
  final List<ProductEntity> products;
  final String? errorMessage;
  final int currentPage;       // current loaded page number
  final bool hasMorePages;     // if more pages are available to load

  const ProductState({
    required this.isLoading,
    required this.isLoadingMore,
    required this.isSuccess,
    this.selectedImageName,
    this.products = const [],
    this.errorMessage,
    this.currentPage = 1,
    this.hasMorePages = true,
  });

  // Initial state
  const ProductState.initial()
      : isLoading = false,
        isLoadingMore = false,
        isSuccess = false,
        selectedImageName = null,
        products = const [],
        errorMessage = null,
        currentPage = 1,
        hasMorePages = true;

  // CopyWith for updating state
  ProductState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? isSuccess,
    String? selectedImageName,
    List<ProductEntity>? products,
    String? errorMessage,
    int? currentPage,
    bool? hasMorePages,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSuccess: isSuccess ?? this.isSuccess,
      selectedImageName: selectedImageName ?? this.selectedImageName,
      products: products ?? this.products,
      errorMessage: errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasMorePages: hasMorePages ?? this.hasMorePages,
    );
  }

  // Equatable props
  @override
  List<Object?> get props => [
        isLoading,
        isLoadingMore,
        isSuccess,
        selectedImageName,
        products,
        errorMessage,
        currentPage,
        hasMorePages,
      ];
}
