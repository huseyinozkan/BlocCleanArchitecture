import 'dart:convert';

import 'package:bloc_clean_architecture/src/common/gen/assets.gen.dart';
import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_pref_keys.dart';
import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_prefences_manager.dart';
import 'package:bloc_clean_architecture/src/data/model/response/culture_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/localization_dto.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

abstract interface class ILocalizationLocalDS {
  CultureDto? getSelectedCulture();
  Future<bool> setSelectedCulture(CultureDto culture);
  Future<List<CultureDto>> getCultures();
  Future<LocalizationDto> getLocalization(CultureDto culture);
}

@LazySingleton(as: ILocalizationLocalDS)
class LocalizationLocalDS implements ILocalizationLocalDS {
  const LocalizationLocalDS(this._pref);
  final SharedPreferencesManager _pref;

  @override
  CultureDto? getSelectedCulture() => _pref.getObject(key: SharedPrefKeys.culture, model: const CultureDto());

  @override
  Future<bool> setSelectedCulture(CultureDto culture) => _pref.setObject(key: SharedPrefKeys.culture, value: culture);

  @override
  Future<List<CultureDto>> getCultures() async {
    final jsonString = await rootBundle.loadString(Assets.lang.cultures);
    final json = jsonDecode(jsonString);

    return (json as List<dynamic>).map((e) => CultureDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<LocalizationDto> getLocalization(CultureDto culture) async {
    final path = Assets.lang.values.firstWhere((element) => element.contains(culture.name!));
    final jsonString = await rootBundle.loadString(path);
    final json = jsonDecode(jsonString);
    return LocalizationDto.fromJson(json as Map<String, dynamic>);
  }
}
