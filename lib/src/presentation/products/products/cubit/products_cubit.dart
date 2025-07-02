import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_cart_item_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/cart_item_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/category_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/product_dto.dart';
import 'package:bloc_clean_architecture/src/domain/cart_item/cart_item_repository.dart';
import 'package:bloc_clean_architecture/src/domain/category/category_repository.dart';
import 'package:bloc_clean_architecture/src/domain/product/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'products_state.dart';

@injectable
final class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(
    this._categoryRepository,
    this._productRepository,
    this._cartItemRepository,
  ) : super(const ProductsState()) {
    _cartItemRepository.cartItemStream.listen((data) {
      if (data is CartItemChangedData) cartItemChanged();
    });
  }

  final ICategoryRepository _categoryRepository;
  final IProductRepository _productRepository;
  final ICartItemRepository _cartItemRepository;

  Future<void> initialized(BuildContext context) async {
    final categoriesResponse = await _categoryRepository.findAll().intercept(showSuccessMessage: false);
    final productsResponse = await _productRepository.findAll().intercept(showSuccessMessage: false);
    final cartItemsResponse = await _cartItemRepository.findAll().intercept(showSuccessMessage: false);

    final categories = [CategoryDto(name: LocalizationKey.all.tr(context, listen: false)), ...?categoriesResponse.data];

    emit(
      state.copyWith(
        status: ProductStatus.loaded,
        categories: categories,
        products: productsResponse.data,
        selectedCategory: categories.first,
        cartItems: cartItemsResponse.data,
      ),
    );
  }

  Future<void> cartItemChanged() async {
    final cartItemsResponse = await _cartItemRepository.findAll().intercept(showSuccessMessage: false);
    emit(state.copyWith(cartItems: cartItemsResponse.data));
  }

  Future<void> onRefresh(BuildContext context) async {
    if (state.selectedCategory == null) return;
    late BaseResponse<List<ProductDto>> productsResponse;

    if (state.selectedCategory?.id == null) {
      productsResponse = await _productRepository.findAll().intercept(showSuccessMessage: false);
    } else {
      productsResponse = await _productRepository.findAllByCategoryId(state.selectedCategory!.id!).intercept(showSuccessMessage: false);
    }

    emit(state.copyWith(products: productsResponse.data));
  }

  Future<void> increaseProductQuantity(ProductDto product) async {
    final request = InsertCartItemRequest(productId: product.id);
    await _cartItemRepository.save(request).intercept(showSuccessMessage: false);
    _cartItemRepository.cartItemChanged();
  }

  Future<void> decreaseProductQuantity(ProductDto product) async {
    final cartItem = state.cartItems.lastWhereOrNull((e) => e.product?.id == product.id);
    if (cartItem == null) return;
    await _cartItemRepository.deleteById(cartItem.id!).intercept(showSuccessMessage: false);
    _cartItemRepository.cartItemChanged();
  }

  Future<void> onChangedSelectedCategory(CategoryDto? category) async {
    if (category == null) return;
    late BaseResponse<List<ProductDto>> productsResponse;

    if (category.id == null) {
      productsResponse = await _productRepository.findAll().intercept(showSuccessMessage: false).withIndicator();
    } else {
      productsResponse = await _productRepository.findAllByCategoryId(category.id!).intercept(showSuccessMessage: false).withIndicator();
    }

    emit(state.copyWith(selectedCategory: category, products: productsResponse.data));
  }
}
