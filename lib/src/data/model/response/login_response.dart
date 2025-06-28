import 'package:bloc_clean_architecture/src/data/model/response/user_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@immutable
@JsonSerializable()
final class LoginResponse with BaseModel<LoginResponse> {
  const LoginResponse({
    this.accessToken,
    this.refreshToken,
    this.user,
    this.privacyAgreementHasBeenApproved,
    this.userAgreementHasBeenApproved,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => const LoginResponse().fromJson(json);

  final String? accessToken;
  final String? refreshToken;
  final UserDto? user;
  final bool? privacyAgreementHasBeenApproved;
  final bool? userAgreementHasBeenApproved;

  @override
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  LoginResponse fromJson(Map<String, Object?> json) => _$LoginResponseFromJson(json);

  LoginResponse copyWith({
    String? accessToken,
    String? refreshToken,
    UserDto? user,
    bool? privacyAgreementHasBeenApproved,
    bool? userAgreementHasBeenApproved,
  }) {
    return LoginResponse(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
      privacyAgreementHasBeenApproved: privacyAgreementHasBeenApproved ?? this.privacyAgreementHasBeenApproved,
      userAgreementHasBeenApproved: userAgreementHasBeenApproved ?? this.userAgreementHasBeenApproved,
    );
  }
}
