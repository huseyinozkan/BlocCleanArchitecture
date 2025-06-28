import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_order_status_request.g.dart';

@immutable
@JsonSerializable()
final class UpdateOrderStatusRequest with BaseModel<UpdateOrderStatusRequest> {
  const UpdateOrderStatusRequest({
    this.id,
    this.orderStatus,
  });

  factory UpdateOrderStatusRequest.fromJson(Map<String, dynamic> json) => const UpdateOrderStatusRequest().fromJson(json);

  final int? id;
  final OrderStatus? orderStatus;

  @override
  Map<String, dynamic> toJson() => _$UpdateOrderStatusRequestToJson(this);

  @override
  UpdateOrderStatusRequest fromJson(Map<String, Object?> json) => _$UpdateOrderStatusRequestFromJson(json);
}
