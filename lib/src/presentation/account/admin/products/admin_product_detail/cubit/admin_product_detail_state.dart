part of 'admin_product_detail_cubit.dart';

enum AdminProductDetailStatus {
  initial,
  loaded,
}

@immutable
final class AdminProductDetailState extends Equatable {
  const AdminProductDetailState({
    this.status = AdminProductDetailStatus.initial,
    this.product,
    this.productImage,
    this.categories = const [],
    this.selectedCategory,
  });

  final AdminProductDetailStatus status;
  final ProductDto? product;
  final FileDto? productImage;
  final List<CategoryDto> categories;
  final CategoryDto? selectedCategory;

  @override
  List<Object?> get props => [
        status,
        product,
        productImage,
        categories,
        selectedCategory,
      ];

  AdminProductDetailState copyWith({
    AdminProductDetailStatus? status,
    ProductDto? product,
    FileDto? productImage,
    List<CategoryDto>? categories,
    CategoryDto? selectedCategory,
  }) {
    return AdminProductDetailState(
      status: status ?? this.status,
      product: product ?? this.product,
      productImage: productImage ?? this.productImage,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
