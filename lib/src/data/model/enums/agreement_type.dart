import 'package:json_annotation/json_annotation.dart';

enum AgreementType {
  @JsonValue(0)
  privacyAgreement,
  @JsonValue(1)
  userAgreement,
  ;
}
