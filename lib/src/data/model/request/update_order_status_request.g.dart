// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrderStatusRequest _$UpdateOrderStatusRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderStatusRequest(
      id: (json['id'] as num?)?.toInt(),
      orderStatus:
          $enumDecodeNullable(_$OrderStatusEnumMap, json['orderStatus']),
    );

Map<String, dynamic> _$UpdateOrderStatusRequestToJson(
        UpdateOrderStatusRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderStatus': _$OrderStatusEnumMap[instance.orderStatus],
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'PENDING',
  OrderStatus.preparing: 'PREPARING',
  OrderStatus.cancelled: 'CANCELLED',
  OrderStatus.delivered: 'DELIVERED',
};
