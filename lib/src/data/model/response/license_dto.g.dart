// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'license_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LicenseDto _$LicenseDtoFromJson(Map<String, dynamic> json) => LicenseDto(
      id: (json['id'] as num?)?.toInt(),
      licenseName: json['licenseName'] as String?,
      licenseDate: json['licenseDate'] == null
          ? null
          : DateTime.parse(json['licenseDate'] as String),
    );

Map<String, dynamic> _$LicenseDtoToJson(LicenseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'licenseName': instance.licenseName,
      'licenseDate': instance.licenseDate?.toIso8601String(),
    };
