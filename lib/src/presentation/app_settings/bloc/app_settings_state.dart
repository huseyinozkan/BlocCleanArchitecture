part of 'app_settings_bloc.dart';

@immutable
final class AppSettingsState extends Equatable {
  const AppSettingsState({
    this.colorSchemes = const [],
    this.cultures,
    this.version,
    this.buildNumber,
  });

  final List<MyColorScheme> colorSchemes;
  final List<CultureDto>? cultures;
  final String? version;
  final String? buildNumber;

  @override
  List<Object?> get props => [
        colorSchemes,
        cultures,
        version,
        buildNumber,
      ];

  AppSettingsState copyWith({
    List<MyColorScheme>? colorSchemes,
    List<CultureDto>? cultures,
    CultureDto? selectedCulture,
    String? version,
    String? buildNumber,
  }) {
    return AppSettingsState(
      colorSchemes: colorSchemes ?? this.colorSchemes,
      cultures: cultures ?? this.cultures,
      version: version ?? this.version,
      buildNumber: buildNumber ?? this.buildNumber,
    );
  }
}
