// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => OrderDto(
      id: (json['id'] as num?)?.toInt(),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status']),
      payment: json['payment'] == null
          ? null
          : PaymentDto.fromJson(json['payment'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : AddressDto.fromJson(json['address'] as Map<String, dynamic>),
      orderNote: json['orderNote'] as String?,
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
      cartItems: (json['cartItems'] as List<dynamic>?)
          ?.map((e) => CartItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      lastModifiedDate: json['lastModifiedDate'] == null
          ? null
          : DateTime.parse(json['lastModifiedDate'] as String),
    );

Map<String, dynamic> _$OrderDtoToJson(OrderDto instance) => <String, dynamic>{
      'id': instance.id,
      'totalAmount': instance.totalAmount,
      'status': _$OrderStatusEnumMap[instance.status],
      'payment': instance.payment,
      'address': instance.address,
      'orderNote': instance.orderNote,
      'user': instance.user,
      'cartItems': instance.cartItems,
      'createdDate': instance.createdDate?.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate?.toIso8601String(),
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'PENDING',
  OrderStatus.preparing: 'PREPARING',
  OrderStatus.cancelled: 'CANCELLED',
  OrderStatus.delivered: 'DELIVERED',
};
