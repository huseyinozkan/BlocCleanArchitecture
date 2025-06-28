// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertOrderRequest _$InsertOrderRequestFromJson(Map<String, dynamic> json) =>
    InsertOrderRequest(
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['paymentMethod']),
      addressId: (json['addressId'] as num?)?.toInt(),
      orderNote: json['orderNote'] as String?,
    );

Map<String, dynamic> _$InsertOrderRequestToJson(InsertOrderRequest instance) =>
    <String, dynamic>{
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod],
      'addressId': instance.addressId,
      'orderNote': instance.orderNote,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.cashOnDelivery: 'CASH_ON_DELIVERY',
  PaymentMethod.creditCardOnDelivery: 'CREDIT_CARD_ON_DELIVERY',
};
