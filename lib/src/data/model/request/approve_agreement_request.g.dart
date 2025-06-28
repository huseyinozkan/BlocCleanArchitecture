// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_agreement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproveAgreementRequest _$ApproveAgreementRequestFromJson(
        Map<String, dynamic> json) =>
    ApproveAgreementRequest(
      agreements: (json['agreements'] as List<dynamic>?)
          ?.map((e) => AgreementIdAndType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApproveAgreementRequestToJson(
        ApproveAgreementRequest instance) =>
    <String, dynamic>{
      'agreements': instance.agreements?.map((e) => e.toJson()).toList(),
    };
