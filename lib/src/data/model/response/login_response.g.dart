// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
      privacyAgreementHasBeenApproved:
          json['privacyAgreementHasBeenApproved'] as bool?,
      userAgreementHasBeenApproved:
          json['userAgreementHasBeenApproved'] as bool?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
      'privacyAgreementHasBeenApproved':
          instance.privacyAgreementHasBeenApproved,
      'userAgreementHasBeenApproved': instance.userAgreementHasBeenApproved,
    };
