import 'dart:async';

import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/data/data_source/local/localization/localization_local_ds.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/culture_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/resource_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/response/culture_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/localization_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class ILocalizationRepository {
  /// Local Data Source
  CultureDto? getSelectedCulture();
  Future<bool> setSelectedCulture(CultureDto culture);

  /// Business Logic
  Future<List<CultureDto>> getCulturesRemoteOrLocal();
  Future<LocalizationDto> getLocalizationRemoteOrLocal(CultureDto culture);
  Future<void> changeCulture(CultureDto culture);
  Stream<LocalizationDto> get status;
}

@LazySingleton(as: ILocalizationRepository)
final class LocalizationRepository implements ILocalizationRepository {
  LocalizationRepository(
    this._localizationLocalDS,
    this._cultureRemoteDS,
    this._resourceRemoteDS,
  );

  final ILocalizationLocalDS _localizationLocalDS;
  final ICultureRemoteDS _cultureRemoteDS;
  final IResourceRemoteDS _resourceRemoteDS;

  final _controller = StreamController<LocalizationDto>.broadcast();

  /// Local Data Source
  @override
  CultureDto? getSelectedCulture() => _localizationLocalDS.getSelectedCulture();
  @override
  Future<bool> setSelectedCulture(CultureDto culture) => _localizationLocalDS.setSelectedCulture(culture);

  /// Business Logic
  @override
  Future<List<CultureDto>> getCulturesRemoteOrLocal() async {
    final response = await _cultureRemoteDS.findAll().withIndicator();
    if (response.data.isNotNullAndNotEmpty) return response.data!;
    return _localizationLocalDS.getCultures();
  }

  @override
  Future<LocalizationDto> getLocalizationRemoteOrLocal(CultureDto culture) async {
    final response = await _resourceRemoteDS.findByName(name: culture.name ?? '').withIndicator();
    if (response.isSuccess) return response.data!;
    return _localizationLocalDS.getLocalization(culture);
  }

  @override
  Future<void> changeCulture(CultureDto culture) async {
    await _localizationLocalDS.setSelectedCulture(culture);
    final localization = await getLocalizationRemoteOrLocal(culture);
    _controller.add(localization);
  }

  @override
  Stream<LocalizationDto> get status async* {
    yield* _controller.stream;
  }

  void dispose() {
    _controller.close();
  }
}
