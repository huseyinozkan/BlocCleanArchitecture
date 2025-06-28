// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_address_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertAddressRequest _$InsertAddressRequestFromJson(
        Map<String, dynamic> json) =>
    InsertAddressRequest(
      name: json['name'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      addressDescription: json['addressDescription'] as String?,
    );

Map<String, dynamic> _$InsertAddressRequestToJson(
        InsertAddressRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'city': instance.city,
      'district': instance.district,
      'addressDescription': instance.addressDescription,
    };
