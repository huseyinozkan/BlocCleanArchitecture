import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_address_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_address_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/address_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class IAddressRemoteDS {
  Future<BaseResponse<List<AddressDto>>> findAll();
  Future<BaseResponse<AddressDto>> findById(int id);
  Future<BaseResponse<AddressDto>> save(InsertAddressRequest request);
  Future<BaseResponse<AddressDto>> update(UpdateAddressRequest request);
  Future<BaseResponse<EmptyObject>> deleteById(int id);
}

@LazySingleton(as: IAddressRemoteDS)
final class AddressRemoteDS implements IAddressRemoteDS {
  const AddressRemoteDS(this._networkManager);

  final NetworkManager _networkManager;

  @override
  Future<BaseResponse<List<AddressDto>>> findAll() => _networkManager.request<List<AddressDto>, AddressDto>(
        path: RequestPath.address,
        type: RequestType.get,
        responseEntityModel: const AddressDto(),
      );

  @override
  Future<BaseResponse<AddressDto>> findById(int id) => _networkManager.request<AddressDto, AddressDto>(
        path: RequestPath.address,
        type: RequestType.get,
        responseEntityModel: const AddressDto(),
        pathSuffix: '/$id',
      );

  @override
  Future<BaseResponse<AddressDto>> save(InsertAddressRequest request) => _networkManager.request<AddressDto, AddressDto>(
        path: RequestPath.address,
        type: RequestType.post,
        data: request,
        responseEntityModel: const AddressDto(),
      );

  @override
  Future<BaseResponse<AddressDto>> update(UpdateAddressRequest request) => _networkManager.request<AddressDto, AddressDto>(
        path: RequestPath.address,
        type: RequestType.put,
        data: request,
        responseEntityModel: const AddressDto(),
      );

  @override
  Future<BaseResponse<EmptyObject>> deleteById(int id) => _networkManager.request<EmptyObject, EmptyObject>(
        path: RequestPath.address,
        type: RequestType.delete,
        responseEntityModel: const EmptyObject(),
        pathSuffix: '/$id',
      );
}
