import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_address_request.g.dart';

@immutable
@JsonSerializable()
final class UpdateAddressRequest with BaseModel<UpdateAddressRequest> {
  const UpdateAddressRequest({
    this.id,
    this.name,
    this.city,
    this.district,
    this.addressDescription,
  });

  factory UpdateAddressRequest.fromJson(Map<String, dynamic> json) => const UpdateAddressRequest().fromJson(json);

  final int? id;
  final String? name;
  final String? city;
  final String? district;
  final String? addressDescription;

  @override
  Map<String, dynamic> toJson() => _$UpdateAddressRequestToJson(this);

  @override
  UpdateAddressRequest fromJson(Map<String, Object?> json) => _$UpdateAddressRequestFromJson(json);
}
