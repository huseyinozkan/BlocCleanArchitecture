// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertProductRequest _$InsertProductRequestFromJson(
        Map<String, dynamic> json) =>
    InsertProductRequest(
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      imageFileId: (json['imageFileId'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InsertProductRequestToJson(
        InsertProductRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'imageFileId': instance.imageFileId,
      'categoryId': instance.categoryId,
    };
