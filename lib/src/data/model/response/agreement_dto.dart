import 'package:bloc_clean_architecture/src/data/model/enums/agreement_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agreement_dto.g.dart';

@immutable
@JsonSerializable()
final class AgreementDto with BaseModel<AgreementDto> {
  const AgreementDto({
    this.id,
    this.version,
    this.cultureName,
    this.content,
    this.type,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory AgreementDto.fromJson(Map<String, dynamic> json) => const AgreementDto().fromJson(json);

  final int? id;
  final int? version;
  final String? cultureName;
  final String? content;
  final AgreementType? type;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;

  @override
  Map<String, dynamic> toJson() => _$AgreementDtoToJson(this);

  @override
  AgreementDto fromJson(Map<String, Object?> json) => _$AgreementDtoFromJson(json);
}
