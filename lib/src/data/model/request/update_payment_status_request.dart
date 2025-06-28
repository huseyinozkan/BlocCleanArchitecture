import 'package:bloc_clean_architecture/src/data/model/enums/payment_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_payment_status_request.g.dart';

@immutable
@JsonSerializable()
final class UpdatePaymentStatusRequest with BaseModel<UpdatePaymentStatusRequest> {
  const UpdatePaymentStatusRequest({
    this.id,
    this.paymentStatus,
  });

  factory UpdatePaymentStatusRequest.fromJson(Map<String, dynamic> json) => const UpdatePaymentStatusRequest().fromJson(json);

  final int? id;
  final PaymentStatus? paymentStatus;

  @override
  Map<String, dynamic> toJson() => _$UpdatePaymentStatusRequestToJson(this);

  @override
  UpdatePaymentStatusRequest fromJson(Map<String, Object?> json) => _$UpdatePaymentStatusRequestFromJson(json);
}
