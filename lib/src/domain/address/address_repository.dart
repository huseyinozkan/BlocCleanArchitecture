import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/address_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_address_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_address_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/address_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class IAddressRepository {
  Future<BaseResponse<List<AddressDto>>> findAll();
  Future<BaseResponse<AddressDto>> findById(int id);
  Future<BaseResponse<AddressDto>> save(InsertAddressRequest request);
  Future<BaseResponse<AddressDto>> update(UpdateAddressRequest request);
  Future<BaseResponse<EmptyObject>> deleteById(int id);
}

@LazySingleton(as: IAddressRepository)
final class AddressRepository implements IAddressRepository {
  const AddressRepository(this._addressRemoteDS);

  final IAddressRemoteDS _addressRemoteDS;

  @override
  Future<BaseResponse<List<AddressDto>>> findAll() => _addressRemoteDS.findAll();

  @override
  Future<BaseResponse<AddressDto>> findById(int id) => _addressRemoteDS.findById(id);

  @override
  Future<BaseResponse<AddressDto>> save(InsertAddressRequest request) => _addressRemoteDS.save(request);

  @override
  Future<BaseResponse<AddressDto>> update(UpdateAddressRequest request) => _addressRemoteDS.update(request);

  @override
  Future<BaseResponse<EmptyObject>> deleteById(int id) => _addressRemoteDS.deleteById(id);
}
