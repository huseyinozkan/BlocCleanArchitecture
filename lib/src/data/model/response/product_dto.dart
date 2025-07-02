import 'package:bloc_clean_architecture/src/data/model/response/category_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/file_id_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@immutable
@JsonSerializable()
final class ProductDto with BaseModel<ProductDto> {
  const ProductDto({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageFile,
    this.category,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) => const ProductDto().fromJson(json);

  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final FileIdDto? imageFile;
  final CategoryDto? category;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;

  @override
  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  @override
  ProductDto fromJson(Map<String, Object?> json) => _$ProductDtoFromJson(json);
}

extension ProductDtoExtension on ProductDto {
  String get priceToCurrency => '${Core.doubleToCurrency(price ?? 0)} ₺';
}
