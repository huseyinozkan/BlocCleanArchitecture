part of 'localization_key.dart';

extension LocalizationKeyExtension on LocalizationKey {
  String tr(BuildContext context, {bool listen = true}) {
    late final LocalizationDto? localization;
    if (listen) {
      localization = context.select((LocalizationBloc bloc) => bloc.state.localization);
    } else {
      localization = context.read<LocalizationBloc>().state.localization;
    }
    final resource = localization?.resources?.firstWhere(
      (element) => element.key == value,
      orElse: () => ResourceDto(value: defaultValue),
    );
    return resource?.value ?? defaultValue;
  }

  String trParams(BuildContext context, {bool listen = true, List<String?> params = const []}) {
    var temp = tr(context, listen: listen);
    for (var i = 0; i < params.length; i++) {
      temp = temp.replaceAll('{$i}', params[i] ?? 'null');
    }
    return temp;
  }
}
