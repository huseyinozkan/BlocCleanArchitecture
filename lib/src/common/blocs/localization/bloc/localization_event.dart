part of 'localization_bloc.dart';

sealed class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class _LocalizationChanged extends LocalizationEvent {
  const _LocalizationChanged(this.localization);

  final LocalizationDto localization;

  @override
  List<Object> get props => [localization];
}

class CultureChanged extends LocalizationEvent {
  const CultureChanged(this.culture);

  final CultureDto culture;

  @override
  List<Object> get props => [culture];
}

class LocalizationChangeToggleClicked extends LocalizationEvent {
  const LocalizationChangeToggleClicked();

  @override
  List<Object> get props => [];
}
