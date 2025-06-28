import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_culture_request.g.dart';

@immutable
@JsonSerializable()
final class UpdateCultureRequest with BaseModel<UpdateCultureRequest> {
  const UpdateCultureRequest({
    this.id,
    this.name,
    this.title,
  });

  factory UpdateCultureRequest.fromJson(Map<String, dynamic> json) => const UpdateCultureRequest().fromJson(json);

  final int? id;
  final String? name;
  final String? title;

  @override
  Map<String, dynamic> toJson() => _$UpdateCultureRequestToJson(this);

  @override
  UpdateCultureRequest fromJson(Map<String, Object?> json) => _$UpdateCultureRequestFromJson(json);
}
