// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agreement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgreementDto _$AgreementDtoFromJson(Map<String, dynamic> json) => AgreementDto(
      id: (json['id'] as num?)?.toInt(),
      version: (json['version'] as num?)?.toInt(),
      cultureName: json['cultureName'] as String?,
      content: json['content'] as String?,
      type: $enumDecodeNullable(_$AgreementTypeEnumMap, json['type']),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      lastModifiedDate: json['lastModifiedDate'] == null
          ? null
          : DateTime.parse(json['lastModifiedDate'] as String),
    );

Map<String, dynamic> _$AgreementDtoToJson(AgreementDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'cultureName': instance.cultureName,
      'content': instance.content,
      'type': _$AgreementTypeEnumMap[instance.type],
      'createdDate': instance.createdDate?.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate?.toIso8601String(),
    };

const _$AgreementTypeEnumMap = {
  AgreementType.privacyAgreement: 0,
  AgreementType.userAgreement: 1,
};
