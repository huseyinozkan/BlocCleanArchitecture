import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_order_status_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/order_dto.dart';
import 'package:bloc_clean_architecture/src/domain/order/order_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'past_orders_state.dart';

@injectable
final class PastOrdersCubit extends Cubit<PastOrdersState> {
  PastOrdersCubit(
    this._orderRepository,
    this._popupManager,
  ) : super(const PastOrdersState());

  final IOrderRepository _orderRepository;
  final IMyPopupManager _popupManager;

  Future<void> initialized() async {
    final response = await _orderRepository.findAll().intercept(showSuccessMessage: false);
    emit(state.copyWith(orders: response.data, status: PastOrdersStatus.loaded));
  }

  Future<void> refresh() async {
    final response = await _orderRepository.findAll().intercept(showSuccessMessage: false);
    emit(state.copyWith(orders: response.data));
  }

  Future<void> onClickedCancelButton({required OrderDto order}) async {
    final request = UpdateOrderStatusRequest(id: order.id, orderStatus: OrderStatus.cancelled);
    final response = await _orderRepository.updateOrderStatus(request).intercept().withIndicator();
    if (response.isFailure) return;
    await refresh();
  }

  Future<void> onClickedOrderDetail(BuildContext context, {required OrderDto order}) async {
    final response = await _orderRepository.findById(order.id).intercept(showSuccessMessage: false).withIndicator();
    if (response.isFailure) return;

    if (context.mounted) {
      final result = await _popupManager.bottomSheets.showOrderDetailBottomSheet(context: context, order: response.data!);
      if (result ?? false) await refresh();
    }
  }
}
