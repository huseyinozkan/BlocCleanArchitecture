import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_dto.g.dart';

@immutable
@JsonSerializable()
final class AddressDto with BaseModel<AddressDto> {
  const AddressDto({
    this.id,
    this.name,
    this.city,
    this.district,
    this.addressDescription,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) => const AddressDto().fromJson(json);

  final int? id;
  final String? name;
  final String? city;
  final String? district;
  final String? addressDescription;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;

  @override
  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

  @override
  AddressDto fromJson(Map<String, Object?> json) => _$AddressDtoFromJson(json);
}
