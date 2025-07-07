import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:bloc_clean_architecture/src/data/model/response/order_dto.dart';
import 'package:bloc_clean_architecture/src/domain/order/order_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'admin_orders_orders_state.dart';

@injectable
final class AdminOrdersCubit extends Cubit<AdminOrdersState> {
  AdminOrdersCubit(
    this._orderRepository,
    this._popupManager,
  ) : super(const AdminOrdersState());

  final IOrderRepository _orderRepository;
  final IMyPopupManager _popupManager;

  final orderStatusController = TextEditingController();

  Future<void> initialized(BuildContext context) async {
    final selectedOrderStatus = OrderStatus.values.first;
    orderStatusController.text = selectedOrderStatus.localizationKey.tr(context, listen: false);
    final response = await _orderRepository.findAllAdminByOrderStatus(selectedOrderStatus).intercept(showSuccessMessage: false);
    emit(state.copyWith(selectedOrderStatus: selectedOrderStatus, orders: response.data, status: AdminOrdersStatus.loaded));
  }

  Future<void> refresh() async {
    final response = await _orderRepository.findAllAdminByOrderStatus(state.selectedOrderStatus).intercept(showSuccessMessage: false);
    emit(state.copyWith(orders: response.data));
  }

  Future<void> onChangeOrderStatus(BuildContext context, {required OrderStatus orderStatus}) async {
    orderStatusController.text = orderStatus.localizationKey.tr(context, listen: false);
    final response = await _orderRepository.findAllAdminByOrderStatus(orderStatus).intercept().withIndicator();
    emit(state.copyWith(orders: response.data, selectedOrderStatus: orderStatus));
  }

  Future<void> onClickedOrderDetail(BuildContext context, {required OrderDto order}) async {
    final response = await _orderRepository.findById(order.id).intercept(showSuccessMessage: false).withIndicator();
    if (response.isFailure) return;

    if (context.mounted) {
      await _popupManager.bottomSheets.showAdminOrderDetailBottomSheet(context: context, order: response.data!);
      await refresh();
    }
  }
}
