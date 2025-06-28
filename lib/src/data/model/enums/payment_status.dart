import 'package:json_annotation/json_annotation.dart';

enum PaymentStatus {
  @JsonValue('WAITING')
  waiting,
  @JsonValue('PAID')
  paid,
}
