import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_category_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_category_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/category_dto.dart';
import 'package:bloc_clean_architecture/src/domain/category/category_repository.dart';
import 'package:bloc_clean_architecture/src/presentation/account/admin/categories/category_detail/view/category_detail_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'category_detail_state.dart';

@injectable
final class CategoryDetailCubit extends Cubit<CategoryDetailState> {
  CategoryDetailCubit(
    this._categoryRepository,
    this._routerService,
  ) : super(const CategoryDetailState());

  late final CategoryDetailArguments? arguments;

  final ICategoryRepository _categoryRepository;
  final IMyRouterService _routerService;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  void initialized(CategoryDetailArguments? arguments) {
    this.arguments = arguments;

    if (arguments?.categoryId == null) {
      initializeForInsert();
    } else {
      initializeForUpdate();
    }
  }

  Future<void> initializeForInsert() async {
    emit(state.copyWith(status: CategoryDetailStatus.loaded));
  }

  Future<void> initializeForUpdate() async {
    final response = await _categoryRepository.findById(arguments!.categoryId!).intercept(showSuccessMessage: false);
    nameController.text = response.data?.name ?? '';
    emit(state.copyWith(category: response.data, status: CategoryDetailStatus.loaded));
  }

  Future<void> saveButtonClick() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (arguments?.categoryId == null) {
      await insertCategory();
    } else {
      await updateCategory();
    }
  }

  Future<void> insertCategory() async {
    final request = InsertCategoryRequest(
      name: nameController.text,
    );

    final response = await _categoryRepository.save(request).intercept().withIndicator();
    if (response.isFailure) return;

    _routerService.rootRouter.pop(true);
  }

  Future<void> updateCategory() async {
    final request = UpdateCategoryRequest(
      id: arguments?.categoryId,
      name: nameController.text,
    );

    final response = await _categoryRepository.update(request).intercept().withIndicator();
    if (response.isFailure) return;

    _routerService.rootRouter.pop(true);
  }

  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }
}
