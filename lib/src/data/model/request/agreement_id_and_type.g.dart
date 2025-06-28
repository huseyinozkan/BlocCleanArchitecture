// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agreement_id_and_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgreementIdAndType _$AgreementIdAndTypeFromJson(Map<String, dynamic> json) =>
    AgreementIdAndType(
      id: (json['id'] as num?)?.toInt(),
      type: $enumDecodeNullable(_$AgreementTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$AgreementIdAndTypeToJson(AgreementIdAndType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$AgreementTypeEnumMap[instance.type],
    };

const _$AgreementTypeEnumMap = {
  AgreementType.privacyAgreement: 0,
  AgreementType.userAgreement: 1,
};
