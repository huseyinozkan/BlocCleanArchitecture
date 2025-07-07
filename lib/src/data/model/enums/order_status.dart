import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  @JsonValue('PENDING')
  pending('PENDING', LocalizationKey.orderStatusPending),
  @JsonValue('PREPARING')
  preparing('PREPARING', LocalizationKey.orderStatusPreparing),
  @JsonValue('CANCELLED')
  cancelled('CANCELLED', LocalizationKey.orderStatusCancelled),
  @JsonValue('DELIVERED')
  delivered('DELIVERED', LocalizationKey.orderStatusDelivered);

  const OrderStatus(this.value, this.localizationKey);
  final String value;
  final LocalizationKey localizationKey;
}
