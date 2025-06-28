import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_category_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_category_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/category_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class ICategoryRemoteDS {
  Future<BaseResponse<List<CategoryDto>>> findAll();
  Future<BaseResponse<CategoryDto>> findById(int id);
  Future<BaseResponse<CategoryDto>> save(InsertCategoryRequest request);
  Future<BaseResponse<CategoryDto>> update(UpdateCategoryRequest request);
  Future<BaseResponse<EmptyObject>> deleteById(int id);
}

@LazySingleton(as: ICategoryRemoteDS)
final class CategoryRemoteDS implements ICategoryRemoteDS {
  const CategoryRemoteDS(this._networkManager);

  final NetworkManager _networkManager;

  @override
  Future<BaseResponse<List<CategoryDto>>> findAll() => _networkManager.request<List<CategoryDto>, CategoryDto>(
        path: RequestPath.category,
        type: RequestType.get,
        responseEntityModel: const CategoryDto(),
      );

  @override
  Future<BaseResponse<CategoryDto>> findById(int id) => _networkManager.request<CategoryDto, CategoryDto>(
        path: RequestPath.category,
        type: RequestType.get,
        responseEntityModel: const CategoryDto(),
        pathSuffix: '/$id',
      );

  @override
  Future<BaseResponse<CategoryDto>> save(InsertCategoryRequest request) => _networkManager.request<CategoryDto, CategoryDto>(
        path: RequestPath.category,
        type: RequestType.post,
        data: request,
        responseEntityModel: const CategoryDto(),
      );

  @override
  Future<BaseResponse<CategoryDto>> update(UpdateCategoryRequest request) => _networkManager.request<CategoryDto, CategoryDto>(
        path: RequestPath.category,
        type: RequestType.put,
        data: request,
        responseEntityModel: const CategoryDto(),
      );

  @override
  Future<BaseResponse<EmptyObject>> deleteById(int id) => _networkManager.request<EmptyObject, EmptyObject>(
        path: RequestPath.category,
        type: RequestType.delete,
        responseEntityModel: const EmptyObject(),
        pathSuffix: '/$id',
      );
}
