// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      phoneCode: json['phoneCode'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'phoneCode': instance.phoneCode,
    };
