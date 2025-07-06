import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/data/model/response/address_dto.dart';
import 'package:bloc_clean_architecture/src/domain/address/address_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'address_state.dart';

@injectable
final class AddressCubit extends Cubit<AddressState> {
  AddressCubit(
    this._addressRepository,
  ) : super(const AddressState());

  final IAddressRepository _addressRepository;

  Future<void> initialized() async {
    final response = await _addressRepository.findAll().intercept(showSuccessMessage: false);
    emit(state.copyWith(addresses: response.data, status: AddressStatus.loaded));
  }

  Future<void> onRefresh() async {
    final response = await _addressRepository.findAll().intercept(showSuccessMessage: false);
    emit(state.copyWith(addresses: response.data));
  }

  Future<void> deleteAddress(AddressDto address) async {
    final deleteResponse = await _addressRepository.deleteById(address.id).intercept().withIndicator();
    if (deleteResponse.isFailure) return;
    unawaited(onRefresh());
  }
}
