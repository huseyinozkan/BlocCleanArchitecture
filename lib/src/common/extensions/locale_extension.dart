import 'dart:ui';

extension LocaleExtension on Locale {
  String get languageAndCountryCode => '$languageCode-$countryCode';
}
