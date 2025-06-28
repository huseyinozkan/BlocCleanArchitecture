import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insert_culture_request.g.dart';

@immutable
@JsonSerializable()
final class InsertCultureRequest with BaseModel<InsertCultureRequest> {
  const InsertCultureRequest({
    this.name,
    this.title,
  });

  factory InsertCultureRequest.fromJson(Map<String, dynamic> json) => const InsertCultureRequest().fromJson(json);

  final String? name;
  final String? title;

  @override
  Map<String, dynamic> toJson() => _$InsertCultureRequestToJson(this);

  @override
  InsertCultureRequest fromJson(Map<String, Object?> json) => _$InsertCultureRequestFromJson(json);
}
