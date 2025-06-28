import 'package:bloc_clean_architecture/src/data/model/enums/payment_method.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/payment_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_dto.g.dart';

@immutable
@JsonSerializable()
final class PaymentDto with BaseModel<PaymentDto> {
  const PaymentDto({
    this.id,
    this.paymentMethod,
    this.status,
    this.paidAt,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory PaymentDto.fromJson(Map<String, dynamic> json) => const PaymentDto().fromJson(json);

  final int? id;
  final PaymentMethod? paymentMethod;
  final PaymentStatus? status;
  final DateTime? paidAt;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;

  @override
  Map<String, dynamic> toJson() => _$PaymentDtoToJson(this);

  @override
  PaymentDto fromJson(Map<String, Object?> json) => _$PaymentDtoFromJson(json);
}
