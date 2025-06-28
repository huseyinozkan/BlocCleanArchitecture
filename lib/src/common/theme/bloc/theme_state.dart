part of 'theme_bloc.dart';

@immutable
final class ThemeState extends Equatable {
  const ThemeState({required this.theme});

  factory ThemeState.fromJson(Map<String, dynamic> json) {
    final brightness = json['brightness'] as String;
    return brightness == Brightness.dark.name ? ThemeState(theme: AppConstants.themeConstants.darkTheme.theme) : ThemeState(theme: AppConstants.themeConstants.lightTheme.theme);
  }

  final ThemeData theme;

  @override
  List<Object> get props => [theme];

  Map<String, dynamic> toJson() => {
        'brightness': theme.brightness.name,
      };

  ThemeState copyWith({
    ThemeData? theme,
  }) {
    return ThemeState(
      theme: theme ?? this.theme,
    );
  }
}
