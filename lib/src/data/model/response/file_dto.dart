import 'package:bloc_clean_architecture/src/data/model/enums/file_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file_dto.g.dart';

@immutable
@JsonSerializable()
final class FileDto with BaseModel<FileDto> {
  const FileDto({
    this.id,
    this.fileName,
    this.fileType,
    this.data,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory FileDto.fromJson(Map<String, dynamic> json) => const FileDto().fromJson(json);

  final int? id;
  final String? fileName;
  final FileType? fileType;
  final String? data;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;

  @override
  Map<String, dynamic> toJson() => _$FileDtoToJson(this);

  @override
  FileDto fromJson(Map<String, Object?> json) => _$FileDtoFromJson(json);
}
