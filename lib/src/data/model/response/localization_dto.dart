import 'package:bloc_clean_architecture/src/data/model/response/culture_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/resource_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'localization_dto.g.dart';

@immutable
@JsonSerializable()
final class LocalizationDto with BaseModel<LocalizationDto> {
  const LocalizationDto({
    this.culture,
    this.resources,
  });

  factory LocalizationDto.fromJson(Map<String, dynamic> json) => const LocalizationDto().fromJson(json);

  final CultureDto? culture;
  final List<ResourceDto>? resources;

  @override
  Map<String, dynamic> toJson() => _$LocalizationDtoToJson(this);

  @override
  LocalizationDto fromJson(Map<String, Object?> json) => _$LocalizationDtoFromJson(json);
}
