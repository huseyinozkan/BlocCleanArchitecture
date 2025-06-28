// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionInfoDto _$AppVersionInfoDtoFromJson(Map<String, dynamic> json) =>
    AppVersionInfoDto(
      version: json['version'] as String,
      isForce: json['isForce'] as bool,
    );

Map<String, dynamic> _$AppVersionInfoDtoToJson(AppVersionInfoDto instance) =>
    <String, dynamic>{
      'version': instance.version,
      'isForce': instance.isForce,
    };
