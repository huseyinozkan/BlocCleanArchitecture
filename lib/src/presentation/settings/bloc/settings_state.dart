part of 'settings_bloc.dart';

@immutable
final class SettingsState extends Equatable {
  const SettingsState({
    this.colorSchemes = const [],
    this.cultures,
  });

  final List<MyColorScheme> colorSchemes;
  final List<CultureDto>? cultures;

  @override
  List<Object?> get props => [
        colorSchemes,
        cultures,
      ];

  SettingsState copyWith({
    List<MyColorScheme>? colorSchemes,
    List<CultureDto>? cultures,
    CultureDto? selectedCulture,
  }) {
    return SettingsState(
      colorSchemes: colorSchemes ?? this.colorSchemes,
      cultures: cultures ?? this.cultures,
    );
  }
}
