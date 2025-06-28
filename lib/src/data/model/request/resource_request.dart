import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resource_request.g.dart';

@immutable
@JsonSerializable()
final class ResourceRequest with BaseModel<ResourceRequest> {
  const ResourceRequest({
    this.key,
    this.value,
  });

  factory ResourceRequest.fromJson(Map<String, dynamic> json) => const ResourceRequest().fromJson(json);

  final String? key;
  final String? value;

  @override
  Map<String, dynamic> toJson() => _$ResourceRequestToJson(this);

  @override
  ResourceRequest fromJson(Map<String, Object?> json) => _$ResourceRequestFromJson(json);
}
