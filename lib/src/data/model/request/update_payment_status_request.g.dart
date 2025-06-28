// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_payment_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePaymentStatusRequest _$UpdatePaymentStatusRequestFromJson(
        Map<String, dynamic> json) =>
    UpdatePaymentStatusRequest(
      id: (json['id'] as num?)?.toInt(),
      paymentStatus:
          $enumDecodeNullable(_$PaymentStatusEnumMap, json['paymentStatus']),
    );

Map<String, dynamic> _$UpdatePaymentStatusRequestToJson(
        UpdatePaymentStatusRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus],
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.waiting: 'WAITING',
  PaymentStatus.paid: 'PAID',
};
