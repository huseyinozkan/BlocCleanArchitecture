import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_culture_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_culture_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/culture_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class ICultureRemoteDS {
  Future<BaseResponse<List<CultureDto>>> findAll();
  Future<BaseResponse<CultureDto>> findById({required int id});
  Future<BaseResponse<CultureDto>> save({required InsertCultureRequest request});
  Future<BaseResponse<CultureDto>> update({required UpdateCultureRequest request});
  Future<BaseResponse<EmptyObject>> deleteById({required int id});
}

@LazySingleton(as: ICultureRemoteDS)
final class CultureRemoteDS implements ICultureRemoteDS {
  const CultureRemoteDS(this._networkManager);

  final NetworkManager _networkManager;

  @override
  Future<BaseResponse<List<CultureDto>>> findAll() {
    return _networkManager.request<List<CultureDto>, CultureDto>(
      path: RequestPath.culture,
      type: RequestType.get,
      responseEntityModel: const CultureDto(),
    );
  }

  @override
  Future<BaseResponse<CultureDto>> findById({required int id}) {
    return _networkManager.request<CultureDto, CultureDto>(
      path: RequestPath.culture,
      type: RequestType.get,
      responseEntityModel: const CultureDto(),
      pathSuffix: '/$id',
    );
  }

  @override
  Future<BaseResponse<CultureDto>> save({required InsertCultureRequest request}) {
    return _networkManager.request<CultureDto, CultureDto>(
      path: RequestPath.culture,
      type: RequestType.post,
      responseEntityModel: const CultureDto(),
      data: request,
    );
  }

  @override
  Future<BaseResponse<CultureDto>> update({required UpdateCultureRequest request}) {
    return _networkManager.request<CultureDto, CultureDto>(
      path: RequestPath.culture,
      type: RequestType.put,
      responseEntityModel: const CultureDto(),
      data: request,
    );
  }

  @override
  Future<BaseResponse<EmptyObject>> deleteById({required int id}) {
    return _networkManager.request<EmptyObject, EmptyObject>(
      path: RequestPath.culture,
      type: RequestType.delete,
      responseEntityModel: const EmptyObject(),
      pathSuffix: '/$id',
    );
  }
}
