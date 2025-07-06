import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_address_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_address_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/address_dto.dart';
import 'package:bloc_clean_architecture/src/domain/address/address_repository.dart';
import 'package:bloc_clean_architecture/src/presentation/address/address_detail/view/address_detail_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'address_detail_state.dart';

@injectable
final class AddressDetailCubit extends Cubit<AddressDetailState> {
  AddressDetailCubit(
    this._addressRepository,
    this._routerService,
  ) : super(const AddressDetailState());

  late final AddressDetailArguments? arguments;

  final IAddressRepository _addressRepository;
  final IMyRouterService _routerService;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final addressDescriptionController = TextEditingController();

  void initialized(AddressDetailArguments? arguments) {
    this.arguments = arguments;

    if (arguments?.addressId == null) {
      initializeForInsert();
    } else {
      initializeForUpdate();
    }
  }

  Future<void> initializeForInsert() async {
    emit(state.copyWith(status: AddressDetailStatus.loaded));
  }

  Future<void> initializeForUpdate() async {
    final response = await _addressRepository.findById(arguments!.addressId!).intercept(showSuccessMessage: false);

    nameController.text = response.data?.name ?? '';
    cityController.text = response.data?.city ?? '';
    districtController.text = response.data?.district ?? '';
    addressDescriptionController.text = response.data?.addressDescription ?? '';

    emit(state.copyWith(address: response.data, status: AddressDetailStatus.loaded));
  }

  Future<void> saveButtonClick() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (arguments?.addressId == null) {
      await insertAddress();
    } else {
      await updateAddress();
    }
  }

  Future<void> insertAddress() async {
    final request = InsertAddressRequest(
      name: nameController.text,
      city: cityController.text,
      district: districtController.text,
      addressDescription: addressDescriptionController.text,
    );

    final response = await _addressRepository.save(request).intercept().withIndicator();
    if (response.isFailure) return;

    if (arguments?.fromPath == RoutePaths.order) {
      _routerService.rootRouter.pop(response.data);
      return;
    }

    _routerService.rootRouter.pop(true);
  }

  Future<void> updateAddress() async {
    final request = UpdateAddressRequest(
      id: arguments?.addressId,
      name: nameController.text,
      city: cityController.text,
      district: districtController.text,
      addressDescription: addressDescriptionController.text,
    );

    final response = await _addressRepository.update(request).intercept().withIndicator();
    if (response.isFailure) return;

    if (arguments?.fromPath == RoutePaths.order) {
      _routerService.rootRouter.pop(response.data);
      return;
    }

    _routerService.rootRouter.pop(true);
  }

  @override
  Future<void> close() {
    nameController.dispose();
    cityController.dispose();
    districtController.dispose();
    addressDescriptionController.dispose();
    return super.close();
  }
}
