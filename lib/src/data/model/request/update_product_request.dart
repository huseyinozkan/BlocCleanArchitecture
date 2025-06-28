import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_product_request.g.dart';

@immutable
@JsonSerializable()
final class UpdateProductRequest with BaseModel<UpdateProductRequest> {
  const UpdateProductRequest({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageFileId,
    this.categoryId,
  });

  factory UpdateProductRequest.fromJson(Map<String, dynamic> json) => const UpdateProductRequest().fromJson(json);

  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final int? imageFileId;
  final int? categoryId;

  @override
  Map<String, dynamic> toJson() => _$UpdateProductRequestToJson(this);

  @override
  UpdateProductRequest fromJson(Map<String, Object?> json) => _$UpdateProductRequestFromJson(json);
}
