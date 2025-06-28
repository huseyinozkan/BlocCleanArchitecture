import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/theme/color_scheme.dart';
import 'package:bloc_clean_architecture/src/data/model/response/culture_dto.dart';
import 'package:bloc_clean_architecture/src/domain/localization/localization_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

@injectable
class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc(this._localizationRepository) : super(const AppSettingsState()) {
    on<AppSettingsInitialEvent>(_appSettingsInitialEvent);
  }

  final ILocalizationRepository _localizationRepository;

  Future<void> _appSettingsInitialEvent(AppSettingsInitialEvent event, Emitter<AppSettingsState> emit) async {
    final colorSchemes = [AppConstants.themeConstants.lightTheme, AppConstants.themeConstants.darkTheme];
    final cultures = await _localizationRepository.getCulturesRemoteOrLocal();
    final selectedCulture = _localizationRepository.getSelectedCulture();
    final version = await CorePackageInfo.instance.version;
    final buildNumber = await CorePackageInfo.instance.buildNumber;
    emit(state.copyWith(colorSchemes: colorSchemes, cultures: cultures, selectedCulture: selectedCulture, version: version, buildNumber: buildNumber));
  }
}
