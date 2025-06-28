// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_code_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpCodeRequest _$SendOtpCodeRequestFromJson(Map<String, dynamic> json) =>
    SendOtpCodeRequest(
      phoneCode: json['phoneCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      purpose: $enumDecodeNullable(_$OtpPurposeEnumMap, json['purpose']),
    );

Map<String, dynamic> _$SendOtpCodeRequestToJson(SendOtpCodeRequest instance) =>
    <String, dynamic>{
      'phoneCode': instance.phoneCode,
      'phoneNumber': instance.phoneNumber,
      'purpose': _$OtpPurposeEnumMap[instance.purpose],
    };

const _$OtpPurposeEnumMap = {
  OtpPurpose.register: 'REGISTER',
  OtpPurpose.forgotPassword: 'FORGOT_PASSWORD',
};
