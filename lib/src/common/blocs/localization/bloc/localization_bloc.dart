import 'package:bloc_clean_architecture/src/common/blocs/localization/bloc/localization_state.dart';
import 'package:bloc_clean_architecture/src/data/model/response/culture_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/localization_dto.dart';
import 'package:bloc_clean_architecture/src/domain/localization/localization_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'localization_event.dart';

@lazySingleton
class LocalizationBloc extends HydratedBloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc(this._localizationRepository) : super(const LocalizationState()) {
    on<_LocalizationChanged>(_localizationChanged);
    on<CultureChanged>(_cultureChanged);
    on<LocalizationChangeToggleClicked>(_localizationChangeToggleClicked);

    _localizationRepository.status.listen((localization) {
      add(_LocalizationChanged(localization));
    });
  }

  final ILocalizationRepository _localizationRepository;

  Future<void> _localizationChanged(_LocalizationChanged event, Emitter<LocalizationState> emit) async {
    emit(state.copyWith(localization: event.localization));
  }

  Future<void> _cultureChanged(CultureChanged event, Emitter<LocalizationState> emit) async {
    await _localizationRepository.changeCulture(event.culture);
  }

  Future<void> _localizationChangeToggleClicked(LocalizationChangeToggleClicked event, Emitter<LocalizationState> emit) async {
    final culture = _localizationRepository.getSelectedCulture();
    final cultures = await _localizationRepository.getCulturesRemoteOrLocal();
    if (culture == null || cultures.isEmpty) return;
    final index = cultures.indexWhere((item) => item.name == culture.name);
    final newCulture = cultures[(index + 1) % cultures.length];
    await _localizationRepository.changeCulture(newCulture);
  }

  @override
  LocalizationState? fromJson(Map<String, dynamic> json) => LocalizationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LocalizationState state) => state.toJson();
}
