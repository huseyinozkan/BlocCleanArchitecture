// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordRequest _$ForgotPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordRequest(
      phoneCode: json['phoneCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      code: json['code'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordRequestToJson(
        ForgotPasswordRequest instance) =>
    <String, dynamic>{
      'phoneCode': instance.phoneCode,
      'phoneNumber': instance.phoneNumber,
      'code': instance.code,
      'newPassword': instance.newPassword,
    };
