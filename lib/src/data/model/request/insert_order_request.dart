import 'package:bloc_clean_architecture/src/data/model/enums/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insert_order_request.g.dart';

@immutable
@JsonSerializable()
final class InsertOrderRequest with BaseModel<InsertOrderRequest> {
  const InsertOrderRequest({
    this.paymentMethod,
    this.addressId,
    this.orderNote,
  });

  factory InsertOrderRequest.fromJson(Map<String, dynamic> json) => const InsertOrderRequest().fromJson(json);

  final PaymentMethod? paymentMethod;
  final int? addressId;
  final String? orderNote;

  @override
  Map<String, dynamic> toJson() => _$InsertOrderRequestToJson(this);

  @override
  InsertOrderRequest fromJson(Map<String, Object?> json) => _$InsertOrderRequestFromJson(json);
}
