import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:json_annotation/json_annotation.dart';

enum PaymentMethod {
  @JsonValue('CASH_ON_DELIVERY')
  cashOnDelivery(LocalizationKey.cashOnDelivery),
  @JsonValue('CREDIT_CARD_ON_DELIVERY')
  creditCardOnDelivery(LocalizationKey.creditCardOnDelivery);

  const PaymentMethod(this.localizationKey);
  final LocalizationKey localizationKey;
}
