import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/payment_method.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_order_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/address_dto.dart';
import 'package:bloc_clean_architecture/src/domain/address/address_repository.dart';
import 'package:bloc_clean_architecture/src/domain/cart_item/cart_item_repository.dart';
import 'package:bloc_clean_architecture/src/domain/order/order_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'order_state.dart';

@injectable
final class OrderCubit extends Cubit<OrderState> {
  OrderCubit(
    this._orderRepository,
    this._addressRepository,
    this._cartItemRepository,
    this._routerService,
  ) : super(const OrderState());

  final IOrderRepository _orderRepository;
  final IAddressRepository _addressRepository;
  final ICartItemRepository _cartItemRepository;
  final IMyRouterService _routerService;

  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final paymentMethodController = TextEditingController();
  final orderNoteController = TextEditingController();

  Future<void> initialized(BuildContext context) async {
    final response = await _addressRepository.findAll().intercept(showSuccessMessage: false);
    addressController.text = response.data?.firstOrNull?.name ?? '';
    paymentMethodController.text = PaymentMethod.values.firstOrNull?.localizationKey.tr(context, listen: false) ?? '';
    emit(
      state.copyWith(
        addresses: response.data,
        selectedAddress: response.data?.firstOrNull,
        selectedPaymentMethod: PaymentMethod.values.firstOrNull,
      ),
    );
  }

  void onChangePaymentMethod(BuildContext context, PaymentMethod paymentMethod) {
    paymentMethodController.text = paymentMethod.localizationKey.tr(context, listen: false);
    emit(state.copyWith(selectedPaymentMethod: paymentMethod));
  }

  void onChangedAddress(AddressDto? address) {
    addressController.text = address?.name ?? '';
    emit(state.copyWith(selectedAddress: address));
  }

  Future<void> sendTheOrderButtonPressed() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(formKey.currentState?.validate() ?? false)) return;
    final request = InsertOrderRequest(
      paymentMethod: state.selectedPaymentMethod,
      addressId: state.selectedAddress?.id,
      orderNote: orderNoteController.text,
    );

    final response = await _orderRepository.save(request).intercept().withIndicator();
    if (response.isFailure) return;
    _cartItemRepository.cartItemChanged();
    _routerService.rootRouter.goNamed(RoutePaths.pastOrders.name);
  }

  void newAddressAdded(AddressDto address) {
    addressController.text = address.name ?? '';
    emit(
      state.copyWith(
        addresses: [...state.addresses, address],
        selectedAddress: address,
      ),
    );
  }
}
