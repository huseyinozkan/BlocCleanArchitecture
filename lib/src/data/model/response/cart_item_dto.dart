import 'package:bloc_clean_architecture/src/data/model/response/product_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_dto.g.dart';

@immutable
@JsonSerializable()
final class CartItemDto with BaseModel<CartItemDto> {
  const CartItemDto({
    this.id,
    this.product,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory CartItemDto.fromJson(Map<String, dynamic> json) => const CartItemDto().fromJson(json);

  final int? id;
  final ProductDto? product;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;

  @override
  Map<String, dynamic> toJson() => _$CartItemDtoToJson(this);

  @override
  CartItemDto fromJson(Map<String, Object?> json) => _$CartItemDtoFromJson(json);
}
