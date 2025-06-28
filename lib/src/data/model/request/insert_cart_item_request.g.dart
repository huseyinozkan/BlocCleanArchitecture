// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_cart_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertCartItemRequest _$InsertCartItemRequestFromJson(
        Map<String, dynamic> json) =>
    InsertCartItemRequest(
      productId: (json['productId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InsertCartItemRequestToJson(
        InsertCartItemRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
    };
