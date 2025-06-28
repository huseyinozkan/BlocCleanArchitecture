import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'license_dto.g.dart';

@immutable
@JsonSerializable()
final class LicenseDto with BaseModel<LicenseDto> {
  const LicenseDto({
    this.id,
    this.licenseName,
    this.licenseDate,
  });

  factory LicenseDto.fromJson(Map<String, dynamic> json) => const LicenseDto().fromJson(json);

  final int? id;
  final String? licenseName;
  final DateTime? licenseDate;

  @override
  Map<String, dynamic> toJson() => _$LicenseDtoToJson(this);

  @override
  LicenseDto fromJson(Map<String, Object?> json) => _$LicenseDtoFromJson(json);
}
