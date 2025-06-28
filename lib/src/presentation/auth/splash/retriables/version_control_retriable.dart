import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/extensions/version_comparison_extension.dart';
import 'package:bloc_clean_architecture/src/domain/app_version/app_version_info_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_core/flutter_core.dart';

final class VersionControlRetriable extends Retriable<bool?> {
  VersionControlRetriable({super.maxRetries, super.delayMultiplier});

  IAppVersionInfoRepository get _appVersionInfoRepository => getIt<IAppVersionInfoRepository>();

  @override
  @protected
  Future<bool?> retryCallback() async {
    // Mevcut versiyon ve remote'dan gelen versiyonlar alınır.
    final currentAppVersion = (await CorePackageInfo.instance.version)!;
    final remoteVersions = await _appVersionInfoRepository.appVersionInfos();

    // Remote'dan gelen versiyonlar boşsa güncellenecek versiyon yoktur null döner.
    if (remoteVersions.isEmpty) return null;

    // Remote'dan gelen versiyonlar mevcut versiyondan büyük değilse listeden çıkarılır.
    remoteVersions.removeWhere((element) => !element.version.isGreaterThan(currentAppVersion));

    // Listede versiyon kalmadıysa güncellenecek versiyon yoktur null döner.
    if (remoteVersions.isEmpty) return null;

    // Listede versiyon kaldıysa içerisinde forceUpdate olan bir versiyon varsa true döner.
    return remoteVersions.any((element) => element.isForce);
  }
}
