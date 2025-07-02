part of 'products_cubit.dart';

enum ProductStatus {
  initial,
  loaded,
}

@immutable
final class ProductsState extends Equatable {
  const ProductsState({
    this.categories = const [],
    this.selectedCategory,
    this.products = const [],
    this.status = ProductStatus.initial,
    this.cartItems = const [],
  });

  final List<CategoryDto> categories;
  final CategoryDto? selectedCategory;
  final List<ProductDto> products;
  final ProductStatus status;
  final List<CartItemDto> cartItems;

  @override
  List<Object?> get props => [
        categories,
        selectedCategory,
        products,
        status,
        cartItems,
      ];

  ProductsState copyWith({
    List<CategoryDto>? categories,
    CategoryDto? selectedCategory,
    List<ProductDto>? products,
    ProductStatus? status,
    List<CartItemDto>? cartItems,
  }) {
    return ProductsState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      products: products ?? this.products,
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}
