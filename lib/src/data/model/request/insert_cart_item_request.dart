import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insert_cart_item_request.g.dart';

@immutable
@JsonSerializable()
final class InsertCartItemRequest with BaseModel<InsertCartItemRequest> {
  const InsertCartItemRequest({
    this.productId,
  });

  factory InsertCartItemRequest.fromJson(Map<String, dynamic> json) => const InsertCartItemRequest().fromJson(json);

  final int? productId;

  @override
  Map<String, dynamic> toJson() => _$InsertCartItemRequestToJson(this);

  @override
  InsertCartItemRequest fromJson(Map<String, Object?> json) => _$InsertCartItemRequestFromJson(json);
}
