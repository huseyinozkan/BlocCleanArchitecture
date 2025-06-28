import 'package:bloc_clean_architecture/src/data/model/enums/role_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_dto.g.dart';

@immutable
@JsonSerializable()
final class RoleDto with BaseModel<RoleDto> {
  const RoleDto({
    this.name,
  });

  factory RoleDto.fromJson(Map<String, dynamic> json) => const RoleDto().fromJson(json);

  final RoleType? name;

  @override
  Map<String, dynamic> toJson() => _$RoleDtoToJson(this);

  @override
  RoleDto fromJson(Map<String, Object?> json) => _$RoleDtoFromJson(json);
}
