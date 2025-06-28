import 'package:json_annotation/json_annotation.dart';

enum OtpPurpose {
  @JsonValue('REGISTER')
  register,
  @JsonValue('FORGOT_PASSWORD')
  forgotPassword,
  ;
}
