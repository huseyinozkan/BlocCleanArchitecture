import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/order_detail_bottom_sheet/view/order_detail_bottom_sheet.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_order_status_request.dart';
import 'package:bloc_clean_architecture/src/domain/order/order_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'order_detail_bottom_sheet_state.dart';

@injectable
final class OrderDetailBottomSheetCubit extends Cubit<OrderDetailBottomSheetState> {
  OrderDetailBottomSheetCubit(
    this._orderRepository,
    this._popupManager,
  ) : super(const OrderDetailBottomSheetState());

  final IOrderRepository _orderRepository;
  final IMyPopupManager _popupManager;

  late final OrderDetailBottomSheetArguments argument;

  Future<void>? onClickedCancelButton() async {
    final request = UpdateOrderStatusRequest(id: argument.order.id, orderStatus: OrderStatus.cancelled);
    final response = await _orderRepository.updateOrderStatus(request).intercept().withIndicator();
    if (response.isFailure) return;
    _popupManager.base.hidePopup<bool>(id: argument.bottomSheetId, result: true);
  }
}
