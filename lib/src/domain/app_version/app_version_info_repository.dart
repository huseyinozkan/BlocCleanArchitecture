import 'dart:async';

import 'package:bloc_clean_architecture/src/data/data_source/remote/app_version/app_version_info_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/app_version/response/app_version_info_dto.dart';
import 'package:injectable/injectable.dart';

abstract interface class IAppVersionInfoRepository {
  Future<List<AppVersionInfoDto>> appVersionInfos();
}

@LazySingleton(as: IAppVersionInfoRepository)
final class AppVersionInfoRepository implements IAppVersionInfoRepository {
  AppVersionInfoRepository(this._appVersionStateRemoteDS);

  final IAppVersionInfoRemoteDS _appVersionStateRemoteDS;

  @override
  Future<List<AppVersionInfoDto>> appVersionInfos() => _appVersionStateRemoteDS.appVersionInfos();
}
