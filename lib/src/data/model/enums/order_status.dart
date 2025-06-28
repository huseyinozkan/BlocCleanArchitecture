import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  @JsonValue('PENDING')
  pending('PENDING'),
  @JsonValue('PREPARING')
  preparing('PREPARING'),
  @JsonValue('CANCELLED')
  cancelled('CANCELLED'),
  @JsonValue('DELIVERED')
  delivered('DELIVERED');

  const OrderStatus(this.value);
  final String value;
}
