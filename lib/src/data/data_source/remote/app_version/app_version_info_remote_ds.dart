import 'dart:convert';
import 'dart:io';

import 'package:bloc_clean_architecture/src/data/model/app_version/response/app_version_info_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class IAppVersionInfoRemoteDS {
  Future<List<AppVersionInfoDto>> appVersionInfos();
}

@LazySingleton(as: IAppVersionInfoRemoteDS)
final class AppVersionInfoRemoteDS implements IAppVersionInfoRemoteDS {
  const AppVersionInfoRemoteDS();

  FirebaseRemoteConfig get _remoteConfig => FirebaseRemoteConfig.instance;

  @override
  Future<List<AppVersionInfoDto>> appVersionInfos() async {
    await _remoteConfig.fetchAndActivate();

    final versionsString = _remoteConfig.getString(Platform.isAndroid ? 'androidVersions' : 'iOSVersions');
    final versionsJson = jsonDecode(versionsString) as List;

    final versions = versionsJson.cast<Map<String, dynamic>>().map(AppVersionInfoDto.fromJson).toList();

    return versions;
  }
}
