import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resource_dto.g.dart';

@immutable
@JsonSerializable()
final class ResourceDto with BaseModel<ResourceDto> {
  const ResourceDto({
    this.key,
    this.value,
  });

  factory ResourceDto.fromJson(Map<String, dynamic> json) => const ResourceDto().fromJson(json);

  final String? key;
  final String? value;

  @override
  Map<String, dynamic> toJson() => _$ResourceDtoToJson(this);

  @override
  ResourceDto fromJson(Map<String, Object?> json) => _$ResourceDtoFromJson(json);
}
