import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'culture_dto.g.dart';

@immutable
@JsonSerializable()
final class CultureDto with BaseModel<CultureDto> {
  const CultureDto({
    this.id,
    this.name,
    this.title,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory CultureDto.fromJson(Map<String, dynamic> json) => const CultureDto().fromJson(json);

  final int? id;
  final String? name;
  final String? title;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;

  @override
  Map<String, dynamic> toJson() => _$CultureDtoToJson(this);

  @override
  CultureDto fromJson(Map<String, Object?> json) => _$CultureDtoFromJson(json);
}

extension CultureDtoExtension on CultureDto {
  Locale get locale => Locale(name ?? '', title ?? '');
}
