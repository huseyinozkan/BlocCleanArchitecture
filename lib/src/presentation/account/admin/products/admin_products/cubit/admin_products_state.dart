part of 'admin_products_cubit.dart';

enum AdminProductStatus {
  initial,
  loaded,
}

@immutable
final class AdminProductsState extends Equatable {
  const AdminProductsState({
    this.categories = const [],
    this.selectedCategory,
    this.products = const [],
    this.status = AdminProductStatus.initial,
  });

  final List<CategoryDto> categories;
  final CategoryDto? selectedCategory;
  final List<ProductDto> products;
  final AdminProductStatus status;

  @override
  List<Object?> get props => [
        categories,
        selectedCategory,
        products,
        status,
      ];

  AdminProductsState copyWith({
    List<CategoryDto>? categories,
    CategoryDto? selectedCategory,
    List<ProductDto>? products,
    AdminProductStatus? status,
  }) {
    return AdminProductsState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      products: products ?? this.products,
      status: status ?? this.status,
    );
  }
}
