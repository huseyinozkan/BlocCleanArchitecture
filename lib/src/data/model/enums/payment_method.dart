import 'package:json_annotation/json_annotation.dart';

enum PaymentMethod {
  @JsonValue('CASH_ON_DELIVERY')
  cashOnDelivery,
  @JsonValue('CREDIT_CARD_ON_DELIVERY')
  creditCardOnDelivery,
}
