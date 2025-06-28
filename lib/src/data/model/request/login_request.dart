import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@immutable
@JsonSerializable()
final class LoginRequest with BaseModel<LoginRequest> {
  const LoginRequest({
    this.username,
    this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => const LoginRequest().fromJson(json);

  final String? username;
  final String? password;

  @override
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  LoginRequest fromJson(Map<String, Object?> json) => _$LoginRequestFromJson(json);
}
