import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insert_address_request.g.dart';

@immutable
@JsonSerializable()
final class InsertAddressRequest with BaseModel<InsertAddressRequest> {
  const InsertAddressRequest({
    this.name,
    this.city,
    this.district,
    this.addressDescription,
  });

  factory InsertAddressRequest.fromJson(Map<String, dynamic> json) => const InsertAddressRequest().fromJson(json);

  final String? name;
  final String? city;
  final String? district;
  final String? addressDescription;

  @override
  Map<String, dynamic> toJson() => _$InsertAddressRequestToJson(this);

  @override
  InsertAddressRequest fromJson(Map<String, Object?> json) => _$InsertAddressRequestFromJson(json);
}
