// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'culture_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CultureDto _$CultureDtoFromJson(Map<String, dynamic> json) => CultureDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      title: json['title'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      lastModifiedDate: json['lastModifiedDate'] == null
          ? null
          : DateTime.parse(json['lastModifiedDate'] as String),
    );

Map<String, dynamic> _$CultureDtoToJson(CultureDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'createdDate': instance.createdDate?.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate?.toIso8601String(),
    };
