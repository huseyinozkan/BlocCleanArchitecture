// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordRequest _$UpdatePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    UpdatePasswordRequest(
      oldPassword: json['oldPassword'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$UpdatePasswordRequestToJson(
        UpdatePasswordRequest instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
