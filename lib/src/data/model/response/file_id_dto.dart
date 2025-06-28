import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file_id_dto.g.dart';

@immutable
@JsonSerializable()
final class FileIdDto with BaseModel<FileIdDto> {
  const FileIdDto({
    this.id,
  });

  factory FileIdDto.fromJson(Map<String, dynamic> json) => const FileIdDto().fromJson(json);

  final int? id;

  @override
  Map<String, dynamic> toJson() => _$FileIdDtoToJson(this);

  @override
  FileIdDto fromJson(Map<String, Object?> json) => _$FileIdDtoFromJson(json);
}
