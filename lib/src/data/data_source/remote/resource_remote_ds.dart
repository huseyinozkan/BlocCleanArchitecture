import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/data/model/response/localization_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class IResourceRemoteDS {
  Future<BaseResponse<LocalizationDto>> findByName({required String name});
}

@LazySingleton(as: IResourceRemoteDS)
final class ResourceRemoteDS implements IResourceRemoteDS {
  const ResourceRemoteDS(this._networkManager);

  final NetworkManager _networkManager;

  @override
  Future<BaseResponse<LocalizationDto>> findByName({required String name}) {
    return _networkManager.request<LocalizationDto, LocalizationDto>(
      path: RequestPath.resource,
      type: RequestType.get,
      responseEntityModel: const LocalizationDto(),
      pathSuffix: '/$name',
    );
  }
}
