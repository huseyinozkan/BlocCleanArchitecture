import 'package:bloc_clean_architecture/src/data/model/enums/otp_purpose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_otp_code_request.g.dart';

@immutable
@JsonSerializable()
final class SendOtpCodeRequest with BaseModel<SendOtpCodeRequest> {
  const SendOtpCodeRequest({
    this.phoneCode,
    this.phoneNumber,
    this.purpose,
  });

  factory SendOtpCodeRequest.fromJson(Map<String, dynamic> json) => const SendOtpCodeRequest().fromJson(json);

  final String? phoneCode;
  final String? phoneNumber;
  final OtpPurpose? purpose;

  @override
  Map<String, dynamic> toJson() => _$SendOtpCodeRequestToJson(this);

  @override
  SendOtpCodeRequest fromJson(Map<String, Object?> json) => _$SendOtpCodeRequestFromJson(json);
}
