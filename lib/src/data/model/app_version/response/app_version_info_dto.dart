import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_version_info_dto.g.dart';

@immutable
@JsonSerializable()
final class AppVersionInfoDto extends BaseModel<AppVersionInfoDto> with EquatableMixin {
  const AppVersionInfoDto({
    required this.version,
    required this.isForce,
  });

  factory AppVersionInfoDto.fromJson(Map<String, dynamic> json) => _$AppVersionInfoDtoFromJson(json);

  final String version;
  final bool isForce;

  @override
  AppVersionInfoDto fromJson(Map<String, Object?> json) => _$AppVersionInfoDtoFromJson(json);

  @override
  Map<String, Object?> toJson() => _$AppVersionInfoDtoToJson(this);

  @override
  List<Object?> get props => [
        version,
        isForce,
      ];

  AppVersionInfoDto copyWith({
    int? id,
    String? version,
    bool? isForce,
  }) {
    return AppVersionInfoDto(
      version: version ?? this.version,
      isForce: isForce ?? this.isForce,
    );
  }
}
