// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDto _$PaymentDtoFromJson(Map<String, dynamic> json) => PaymentDto(
      id: (json['id'] as num?)?.toInt(),
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['paymentMethod']),
      status: $enumDecodeNullable(_$PaymentStatusEnumMap, json['status']),
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      lastModifiedDate: json['lastModifiedDate'] == null
          ? null
          : DateTime.parse(json['lastModifiedDate'] as String),
    );

Map<String, dynamic> _$PaymentDtoToJson(PaymentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod],
      'status': _$PaymentStatusEnumMap[instance.status],
      'paidAt': instance.paidAt?.toIso8601String(),
      'createdDate': instance.createdDate?.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate?.toIso8601String(),
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.cashOnDelivery: 'CASH_ON_DELIVERY',
  PaymentMethod.creditCardOnDelivery: 'CREDIT_CARD_ON_DELIVERY',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.waiting: 'WAITING',
  PaymentStatus.paid: 'PAID',
};
