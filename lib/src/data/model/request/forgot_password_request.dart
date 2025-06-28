import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request.g.dart';

@immutable
@JsonSerializable()
final class ForgotPasswordRequest with BaseModel<ForgotPasswordRequest> {
  const ForgotPasswordRequest({
    this.phoneCode,
    this.phoneNumber,
    this.code,
    this.newPassword,
  });

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) => const ForgotPasswordRequest().fromJson(json);

  final String? phoneCode;
  final String? phoneNumber;
  final String? code;
  final String? newPassword;

  @override
  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);

  @override
  ForgotPasswordRequest fromJson(Map<String, Object?> json) => _$ForgotPasswordRequestFromJson(json);
}
