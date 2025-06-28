import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/resource_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/response/localization_dto.dart';
import 'package:injectable/injectable.dart';

abstract interface class IResourceRepository {
  Future<BaseResponse<LocalizationDto>> findByName({required String name});
}

@LazySingleton(as: IResourceRepository)
final class ResourceRepository implements IResourceRepository {
  const ResourceRepository(this._resourceRemoteDS);

  final ResourceRemoteDS _resourceRemoteDS;

  @override
  Future<BaseResponse<LocalizationDto>> findByName({required String name}) => _resourceRemoteDS.findByName(name: name);
}
