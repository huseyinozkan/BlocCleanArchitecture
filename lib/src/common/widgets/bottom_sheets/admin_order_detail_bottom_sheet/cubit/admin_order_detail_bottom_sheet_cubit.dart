import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/admin_order_detail_bottom_sheet/view/admin_order_detail_bottom_sheet.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_order_status_request.dart';
import 'package:bloc_clean_architecture/src/domain/order/order_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'admin_order_detail_bottom_sheet_state.dart';

@injectable
final class AdminOrderDetailBottomSheetCubit extends Cubit<AdminOrderDetailBottomSheetState> {
  AdminOrderDetailBottomSheetCubit(
    this._orderRepository,
    this._popupManager,
  ) : super(const AdminOrderDetailBottomSheetState());

  final IOrderRepository _orderRepository;
  final IMyPopupManager _popupManager;

  late final AdminOrderDetailBottomSheetArguments argument;

  final orderStatusController = TextEditingController();

  void initialized(BuildContext context, AdminOrderDetailBottomSheetArguments argument) {
    this.argument = argument;
    orderStatusController.text = argument.order.status?.localizationKey.tr(context, listen: false) ?? '';
    emit(state.copyWith(selectedOrderStatus: argument.order.status));
  }

  Future<void>? onClickedCancelButton() async {
    final request = UpdateOrderStatusRequest(id: argument.order.id, orderStatus: OrderStatus.cancelled);
    final response = await _orderRepository.updateOrderStatus(request).intercept().withIndicator();
    if (response.isFailure) return;
    _popupManager.base.hidePopup<bool>(id: argument.bottomSheetId, result: true);
  }

  Future<void> onChangeOrderStatus(BuildContext context, {required OrderStatus orderStatus}) async {
    orderStatusController.text = orderStatus.localizationKey.tr(context, listen: false);
    final request = UpdateOrderStatusRequest(id: argument.order.id, orderStatus: orderStatus);
    await _orderRepository.updateOrderStatus(request).intercept().withIndicator();
    emit(state.copyWith(selectedOrderStatus: orderStatus));
  }
}
