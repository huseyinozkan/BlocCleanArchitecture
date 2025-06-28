import 'package:json_annotation/json_annotation.dart';

enum RoleType {
  @JsonValue('ROLE_ADMIN')
  roleAdmin,
  @JsonValue('ROLE_USER')
  roleUser,
  ;
}
