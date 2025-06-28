import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:bloc_clean_architecture/src/data/model/response/address_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/cart_item_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/payment_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/user_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_dto.g.dart';

@immutable
@JsonSerializable()
final class OrderDto with BaseModel<OrderDto> {
  const OrderDto({
    this.id,
    this.totalAmount,
    this.status,
    this.payment,
    this.address,
    this.orderNote,
    this.user,
    this.cartItems,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) => const OrderDto().fromJson(json);

  final int? id;
  final double? totalAmount;
  final OrderStatus? status;
  final PaymentDto? payment;
  final AddressDto? address;
  final String? orderNote;
  final UserDto? user;
  final List<CartItemDto>? cartItems;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;

  @override
  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);

  @override
  OrderDto fromJson(Map<String, Object?> json) => _$OrderDtoFromJson(json);
}
