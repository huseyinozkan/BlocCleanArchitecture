import 'package:bloc_clean_architecture/src/data/model/response/role_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@immutable
@JsonSerializable()
final class UserDto with BaseModel<UserDto> {
  const UserDto({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.username,
    this.createdDate,
    this.lastModifiedDate,
    this.roles,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => const UserDto().fromJson(json);

  final int? id;
  final String? name;
  final String? surname;
  final String? email;
  final String? phoneCode;
  final String? phoneNumber;
  final String? username;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;
  final List<RoleDto>? roles;

  @override
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @override
  UserDto fromJson(Map<String, Object?> json) => _$UserDtoFromJson(json);
}
