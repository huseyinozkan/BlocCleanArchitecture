import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_category_request.g.dart';

@immutable
@JsonSerializable()
final class UpdateCategoryRequest with BaseModel<UpdateCategoryRequest> {
  const UpdateCategoryRequest({
    this.id,
    this.name,
  });

  factory UpdateCategoryRequest.fromJson(Map<String, dynamic> json) => const UpdateCategoryRequest().fromJson(json);

  final int? id;
  final String? name;

  @override
  Map<String, dynamic> toJson() => _$UpdateCategoryRequestToJson(this);

  @override
  UpdateCategoryRequest fromJson(Map<String, Object?> json) => _$UpdateCategoryRequestFromJson(json);
}
