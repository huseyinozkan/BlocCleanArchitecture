import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/file_type.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_product_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_product_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/category_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/file_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/product_dto.dart';
import 'package:bloc_clean_architecture/src/domain/category/category_repository.dart';
import 'package:bloc_clean_architecture/src/domain/file/file_repository.dart';
import 'package:bloc_clean_architecture/src/domain/product/product_repository.dart';
import 'package:bloc_clean_architecture/src/presentation/account/admin/products/admin_product_detail/view/admin_product_detail_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';

part 'admin_product_detail_state.dart';

@injectable
final class AdminProductDetailCubit extends Cubit<AdminProductDetailState> {
  AdminProductDetailCubit(
    this._productRepository,
    this._fileRepository,
    this._categoryRepository,
    this._popupManager,
    this._routerService,
  ) : super(const AdminProductDetailState());

  final IProductRepository _productRepository;
  final IFileRepository _fileRepository;
  final ICategoryRepository _categoryRepository;
  final IMyPopupManager _popupManager;
  final IMyRouterService _routerService;

  late final AdminProductDetailArguments? arguments;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryControler = TextEditingController();

  Future<void> initialized({required AdminProductDetailArguments? arguments}) async {
    this.arguments = arguments;
    if (arguments?.productId != null) {
      await initializeForEdit();
    } else {
      await initializeForCreate();
    }
  }

  Future<void> initializeForEdit() async {
    final productResponse = await _productRepository.findById(arguments?.productId).intercept(showSuccessMessage: false);
    final fileResponse = await _fileRepository.findById(productResponse.data?.imageFile?.id).intercept(showSuccessMessage: false);
    final categoriesResponse = await _categoryRepository.findAll().intercept(showSuccessMessage: false);

    nameController.text = productResponse.data?.name ?? '';
    descriptionController.text = productResponse.data?.description ?? '';
    priceController.setTextForCurrencyFormat((productResponse.data?.price ?? 0).toString());
    categoryControler.text = productResponse.data?.category?.name ?? '';

    emit(
      state.copyWith(
        status: AdminProductDetailStatus.loaded,
        product: productResponse.data,
        productImage: fileResponse.data,
        categories: categoriesResponse.data,
        selectedCategory: categoriesResponse.data?.firstWhereOrNull((c) => c.id == productResponse.data?.category?.id),
      ),
    );
  }

  Future<void> initializeForCreate() async {
    final categoriesResponse = await _categoryRepository.findAll().intercept(showSuccessMessage: false);
    emit(state.copyWith(status: AdminProductDetailStatus.loaded, categories: categoriesResponse.data));
  }

  Future<void> onChangedProductImage(CroppedFile croppedFile) async {
    final bytes = await File(croppedFile.path).readAsBytes();
    final formData = FormData.fromMap({
      'fileType': FileType.png.value,
      'file': MultipartFile.fromBytes(
        bytes,
        filename: basename(croppedFile.path),
        contentType: MediaType('image', 'png'),
      ),
    });

    FileDto? file;
    if (state.productImage?.id == null) {
      final response = await _fileRepository.save(formData).intercept(showSuccessMessage: false).withIndicator();
      if (response.isFailure) return;
      file = response.data;
    } else {
      formData.fields.add(MapEntry('id', state.productImage!.id.toString()));
      final response = await _fileRepository.update(formData).intercept(showSuccessMessage: false).withIndicator();
      if (response.isFailure) return;
      file = response.data;
    }

    emit(state.copyWith(productImage: file));
  }

  void onChangedSelectedCategory(CategoryDto? category) {
    categoryControler.text = category?.name ?? '';
    emit(state.copyWith(selectedCategory: category));
  }

  Future<void> onClickedSaveButton(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (state.productImage == null && context.mounted) {
      unawaited(_popupManager.dialogs.showInfoDialog(context: context, message: LocalizationKey.productImageRequired.tr(context, listen: false)));
      return;
    }

    if (arguments?.productId == null) {
      await insertProduct();
    } else {
      await updateProduct();
    }
  }

  Future<void> insertProduct() async {
    final request = InsertProductRequest(
      name: nameController.text,
      description: descriptionController.text,
      price: double.tryParse(priceController.text.replaceAll(',', '.')),
      imageFileId: state.productImage?.id,
      categoryId: state.selectedCategory?.id,
    );
    final response = await _productRepository.save(request).intercept().withIndicator();
    if (response.isFailure) return;
    _routerService.rootRouter.pop(true);
  }

  Future<void> updateProduct() async {
    final request = UpdateProductRequest(
      id: arguments?.productId,
      name: nameController.text,
      description: descriptionController.text,
      price: double.tryParse(priceController.text.replaceAll(',', '.')),
      imageFileId: state.productImage?.id,
      categoryId: state.selectedCategory?.id,
    );
    final response = await _productRepository.update(request).intercept().withIndicator();
    if (response.isFailure) return;
    _routerService.rootRouter.pop(true);
  }
}
