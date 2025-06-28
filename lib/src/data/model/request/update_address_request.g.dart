// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_address_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAddressRequest _$UpdateAddressRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateAddressRequest(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      addressDescription: json['addressDescription'] as String?,
    );

Map<String, dynamic> _$UpdateAddressRequestToJson(
        UpdateAddressRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'district': instance.district,
      'addressDescription': instance.addressDescription,
    };
