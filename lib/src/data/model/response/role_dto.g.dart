// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleDto _$RoleDtoFromJson(Map<String, dynamic> json) => RoleDto(
      name: $enumDecodeNullable(_$RoleTypeEnumMap, json['name']),
    );

Map<String, dynamic> _$RoleDtoToJson(RoleDto instance) => <String, dynamic>{
      'name': _$RoleTypeEnumMap[instance.name],
    };

const _$RoleTypeEnumMap = {
  RoleType.roleAdmin: 'ROLE_ADMIN',
  RoleType.roleUser: 'ROLE_USER',
};
