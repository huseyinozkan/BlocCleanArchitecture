// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_culture_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCultureRequest _$UpdateCultureRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateCultureRequest(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$UpdateCultureRequestToJson(
        UpdateCultureRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
    };
