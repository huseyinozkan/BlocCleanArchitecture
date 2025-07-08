import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/data/model/response/category_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/product_dto.dart';
import 'package:bloc_clean_architecture/src/domain/category/category_repository.dart';
import 'package:bloc_clean_architecture/src/domain/product/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'admin_products_state.dart';

@injectable
final class AdminProductsCubit extends Cubit<AdminProductsState> {
  AdminProductsCubit(
    this._categoryRepository,
    this._productRepository,
  ) : super(const AdminProductsState());

  final ICategoryRepository _categoryRepository;
  final IProductRepository _productRepository;

  Future<void> initialized(BuildContext context) async {
    final categoriesResponse = await _categoryRepository.findAll().intercept(showSuccessMessage: false);
    final productsResponse = await _productRepository.findAll().intercept(showSuccessMessage: false);

    final categories = [CategoryDto(name: LocalizationKey.all.tr(context, listen: false)), ...?categoriesResponse.data];

    emit(
      state.copyWith(
        status: AdminProductStatus.loaded,
        categories: categories,
        products: productsResponse.data,
        selectedCategory: categories.first,
      ),
    );
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

  Future<void> deleteProduct(BuildContext context, {required ProductDto product}) async {
    final response = await _productRepository.deleteById(product.id).intercept().withIndicator();
    if (response.isFailure) return;
    await onRefresh(context);
  }
}
