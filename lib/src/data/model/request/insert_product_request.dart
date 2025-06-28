import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insert_product_request.g.dart';

@immutable
@JsonSerializable()
final class InsertProductRequest with BaseModel<InsertProductRequest> {
  const InsertProductRequest({
    this.name,
    this.description,
    this.price,
    this.imageFileId,
    this.categoryId,
  });

  factory InsertProductRequest.fromJson(Map<String, dynamic> json) => const InsertProductRequest().fromJson(json);

  final String? name;
  final String? description;
  final double? price;
  final int? imageFileId;
  final int? categoryId;

  @override
  Map<String, dynamic> toJson() => _$InsertProductRequestToJson(this);

  @override
  InsertProductRequest fromJson(Map<String, Object?> json) => _$InsertProductRequestFromJson(json);
}
