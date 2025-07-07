import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/data/model/response/category_dto.dart';
import 'package:bloc_clean_architecture/src/domain/category/category_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'categories_state.dart';

@injectable
final class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(
    this._categoryRepository,
  ) : super(const CategoriesState());

  final ICategoryRepository _categoryRepository;

  Future<void> initialized() async {
    final response = await _categoryRepository.findAll().intercept(showSuccessMessage: false);
    emit(state.copyWith(categories: response.data, status: CategoriesStatus.loaded));
  }

  Future<void> onRefresh() async {
    final response = await _categoryRepository.findAll().intercept(showSuccessMessage: false);
    emit(state.copyWith(categories: response.data));
  }

  Future<void> deleteCategory(CategoryDto category) async {
    final deleteResponse = await _categoryRepository.deleteById(category.id).intercept().withIndicator();
    if (deleteResponse.isFailure) return;
    unawaited(onRefresh());
  }
}
