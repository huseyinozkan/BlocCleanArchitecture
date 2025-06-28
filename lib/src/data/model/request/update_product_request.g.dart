// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProductRequest _$UpdateProductRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateProductRequest(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      imageFileId: (json['imageFileId'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UpdateProductRequestToJson(
        UpdateProductRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'imageFileId': instance.imageFileId,
      'categoryId': instance.categoryId,
    };
