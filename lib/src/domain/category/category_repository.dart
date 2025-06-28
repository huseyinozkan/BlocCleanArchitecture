import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/category_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_category_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_category_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/category_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class ICategoryRepository {
  Future<BaseResponse<List<CategoryDto>>> findAll();
  Future<BaseResponse<CategoryDto>> findById(int id);
  Future<BaseResponse<CategoryDto>> save(InsertCategoryRequest request);
  Future<BaseResponse<CategoryDto>> update(UpdateCategoryRequest request);
  Future<BaseResponse<EmptyObject>> deleteById(int id);
}

@LazySingleton(as: ICategoryRepository)
final class CategoryRepository implements ICategoryRepository {
  const CategoryRepository(this._categoryRemoteDS);

  final ICategoryRemoteDS _categoryRemoteDS;

  @override
  Future<BaseResponse<List<CategoryDto>>> findAll() => _categoryRemoteDS.findAll();

  @override
  Future<BaseResponse<CategoryDto>> findById(int id) => _categoryRemoteDS.findById(id);

  @override
  Future<BaseResponse<CategoryDto>> save(InsertCategoryRequest request) => _categoryRemoteDS.save(request);

  @override
  Future<BaseResponse<CategoryDto>> update(UpdateCategoryRequest request) => _categoryRemoteDS.update(request);

  @override
  Future<BaseResponse<EmptyObject>> deleteById(int id) => _categoryRemoteDS.deleteById(id);
}
