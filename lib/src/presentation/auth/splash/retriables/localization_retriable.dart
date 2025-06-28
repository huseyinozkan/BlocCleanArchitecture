import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/domain/localization/localization_repository.dart';
import 'package:flutter_core/flutter_core.dart';

final class LocalizationRetriable extends Retriable<bool> {
  LocalizationRetriable({super.maxRetries, super.delayMultiplier});

  ILocalizationRepository get _localizationRepository => getIt<ILocalizationRepository>();

  @override
  Future<bool> retryCallback() async {
    final cultures = await _localizationRepository.getCulturesRemoteOrLocal();
    if (cultures.isEmpty) throw Exception('No cultures found');

    final selectedCulture = _localizationRepository.getSelectedCulture();
    if (selectedCulture.isNull) {
      final culture = cultures.first;
      await _localizationRepository.changeCulture(culture);
      return true;
    }

    final culture = cultures.firstWhere((element) => element.name == selectedCulture?.name);
    await _localizationRepository.changeCulture(culture);
    return true;
  }
}
