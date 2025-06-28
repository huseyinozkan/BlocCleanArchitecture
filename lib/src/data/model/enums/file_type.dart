import 'package:json_annotation/json_annotation.dart';

enum FileType {
  @JsonValue('JPEG')
  jpeg('JPEG'),
  @JsonValue('PNG')
  png('PNG'),
  @JsonValue('GIF')
  gif('GIF'),
  @JsonValue('PDF')
  pdf('PDF'),
  @JsonValue('DOCX')
  docx('DOCX'),
  @JsonValue('XLSX')
  xlsx('XLSX'),
  @JsonValue('OTHER')
  other('OTHER'),
  ;

  const FileType(this.value);

  final String value;
}
