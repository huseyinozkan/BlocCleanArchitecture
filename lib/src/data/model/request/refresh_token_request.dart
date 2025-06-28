import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request.g.dart';

@immutable
@JsonSerializable()
final class RefreshTokenRequest with BaseModel<RefreshTokenRequest> {
  const RefreshTokenRequest({
    this.refreshToken,
  });

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) => const RefreshTokenRequest().fromJson(json);

  final String? refreshToken;

  @override
  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);

  @override
  RefreshTokenRequest fromJson(Map<String, Object?> json) => _$RefreshTokenRequestFromJson(json);
}
