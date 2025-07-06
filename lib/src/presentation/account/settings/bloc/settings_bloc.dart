import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/theme/color_scheme.dart';
import 'package:bloc_clean_architecture/src/data/model/response/culture_dto.dart';
import 'package:bloc_clean_architecture/src/domain/localization/localization_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._localizationRepository) : super(const SettingsState()) {
    on<SettingsInitialEvent>(_settingsInitialEvent);
  }

  final ILocalizationRepository _localizationRepository;

  Future<void> _settingsInitialEvent(SettingsInitialEvent event, Emitter<SettingsState> emit) async {
    final colorSchemes = [AppConstants.themeConstants.lightTheme, AppConstants.themeConstants.darkTheme];
    final cultures = await _localizationRepository.getCulturesRemoteOrLocal();
    final selectedCulture = _localizationRepository.getSelectedCulture();
    emit(state.copyWith(colorSchemes: colorSchemes, cultures: cultures, selectedCulture: selectedCulture));
  }
}
