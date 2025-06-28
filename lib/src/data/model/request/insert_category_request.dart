import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insert_category_request.g.dart';

@immutable
@JsonSerializable()
final class InsertCategoryRequest with BaseModel<InsertCategoryRequest> {
  const InsertCategoryRequest({
    this.name,
  });

  factory InsertCategoryRequest.fromJson(Map<String, dynamic> json) => const InsertCategoryRequest().fromJson(json);

  final String? name;

  @override
  Map<String, dynamic> toJson() => _$InsertCategoryRequestToJson(this);

  @override
  InsertCategoryRequest fromJson(Map<String, Object?> json) => _$InsertCategoryRequestFromJson(json);
}
