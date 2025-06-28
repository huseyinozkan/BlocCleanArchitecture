import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@immutable
@JsonSerializable()
final class CategoryDto with BaseModel<CategoryDto> {
  const CategoryDto({
    this.id,
    this.name,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) => const CategoryDto().fromJson(json);

  final int? id;
  final String? name;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;

  @override
  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  @override
  CategoryDto fromJson(Map<String, Object?> json) => _$CategoryDtoFromJson(json);
}
