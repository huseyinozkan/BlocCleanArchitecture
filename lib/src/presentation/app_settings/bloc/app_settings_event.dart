part of 'app_settings_bloc.dart';

@immutable
final class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class AppSettingsInitialEvent extends AppSettingsEvent {
  const AppSettingsInitialEvent();
}
