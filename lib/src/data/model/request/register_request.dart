import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@immutable
@JsonSerializable()
final class RegisterRequest with BaseModel<RegisterRequest> {
  const RegisterRequest({
    this.name,
    this.surname,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.username,
    this.password,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => const RegisterRequest().fromJson(json);

  final String? name;
  final String? surname;
  final String? email;
  final String? phoneCode;
  final String? phoneNumber;
  final String? username;
  final String? password;

  @override
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  @override
  RegisterRequest fromJson(Map<String, Object?> json) => _$RegisterRequestFromJson(json);
}
