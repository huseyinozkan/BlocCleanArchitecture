// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localization_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalizationDto _$LocalizationDtoFromJson(Map<String, dynamic> json) =>
    LocalizationDto(
      culture: json['culture'] == null
          ? null
          : CultureDto.fromJson(json['culture'] as Map<String, dynamic>),
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => ResourceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocalizationDtoToJson(LocalizationDto instance) =>
    <String, dynamic>{
      'culture': instance.culture,
      'resources': instance.resources,
    };
