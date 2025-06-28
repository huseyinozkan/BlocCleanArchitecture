import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_password_request.g.dart';

@immutable
@JsonSerializable()
final class UpdatePasswordRequest with BaseModel<UpdatePasswordRequest> {
  const UpdatePasswordRequest({
    this.oldPassword,
    this.newPassword,
  });

  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> json) => const UpdatePasswordRequest().fromJson(json);

  final String? oldPassword;
  final String? newPassword;

  @override
  Map<String, dynamic> toJson() => _$UpdatePasswordRequestToJson(this);

  @override
  UpdatePasswordRequest fromJson(Map<String, Object?> json) => _$UpdatePasswordRequestFromJson(json);
}
