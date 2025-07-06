import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@immutable
@JsonSerializable()
final class Country extends Equatable with BaseModel<Country> {
  const Country({
    this.countryCode,
    this.countryName,
    this.phoneCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  final String? countryCode;
  final String? countryName;
  final String? phoneCode;

  @override
  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  List<Object?> get props => [countryCode, countryName, phoneCode];

  @override
  Country fromJson(Map<String, Object?> json) => Country.fromJson(json);
}
