// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileDto _$FileDtoFromJson(Map<String, dynamic> json) => FileDto(
      id: (json['id'] as num?)?.toInt(),
      fileName: json['fileName'] as String?,
      fileType: $enumDecodeNullable(_$FileTypeEnumMap, json['fileType']),
      data: json['data'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      lastModifiedDate: json['lastModifiedDate'] == null
          ? null
          : DateTime.parse(json['lastModifiedDate'] as String),
    );

Map<String, dynamic> _$FileDtoToJson(FileDto instance) => <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'fileType': _$FileTypeEnumMap[instance.fileType],
      'data': instance.data,
      'createdDate': instance.createdDate?.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate?.toIso8601String(),
    };

const _$FileTypeEnumMap = {
  FileType.jpeg: 'JPEG',
  FileType.png: 'PNG',
  FileType.gif: 'GIF',
  FileType.pdf: 'PDF',
  FileType.docx: 'DOCX',
  FileType.xlsx: 'XLSX',
  FileType.other: 'OTHER',
};
