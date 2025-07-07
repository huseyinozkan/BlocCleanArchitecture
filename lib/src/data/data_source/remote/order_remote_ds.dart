import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_order_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_order_status_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/order_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class IOrderRemoteDS {
  Future<BaseResponse<List<OrderDto>>> findAll();
  Future<BaseResponse<List<OrderDto>>> findAllAdmin();
  Future<BaseResponse<List<OrderDto>>> findAllAdminByOrderStatus(OrderStatus? orderStatus);
  Future<BaseResponse<OrderDto>> findById(int? id);
  Future<BaseResponse<OrderDto>> save(InsertOrderRequest request);
  Future<BaseResponse<OrderDto>> updateOrderStatus(UpdateOrderStatusRequest request);
}

@LazySingleton(as: IOrderRemoteDS)
final class OrderRemoteDS implements IOrderRemoteDS {
  const OrderRemoteDS(this._networkManager);

  final NetworkManager _networkManager;

  @override
  Future<BaseResponse<List<OrderDto>>> findAll() => _networkManager.request<List<OrderDto>, OrderDto>(
        path: RequestPath.order,
        type: RequestType.get,
        responseEntityModel: const OrderDto(),
      );

  @override
  Future<BaseResponse<List<OrderDto>>> findAllAdmin() => _networkManager.request<List<OrderDto>, OrderDto>(
        path: RequestPath.orderAdmin,
        type: RequestType.get,
        responseEntityModel: const OrderDto(),
      );

  @override
  Future<BaseResponse<List<OrderDto>>> findAllAdminByOrderStatus(OrderStatus? orderStatus) => _networkManager.request<List<OrderDto>, OrderDto>(
        path: RequestPath.orderAdminByOrderStatus,
        type: RequestType.get,
        responseEntityModel: const OrderDto(),
        pathSuffix: '?orderStatus=${orderStatus?.value}',
      );

  @override
  Future<BaseResponse<OrderDto>> findById(int? id) => _networkManager.request<OrderDto, OrderDto>(
        path: RequestPath.order,
        type: RequestType.get,
        responseEntityModel: const OrderDto(),
        pathSuffix: '/$id',
      );

  @override
  Future<BaseResponse<OrderDto>> save(InsertOrderRequest request) => _networkManager.request<OrderDto, OrderDto>(
        path: RequestPath.order,
        type: RequestType.post,
        data: request,
        responseEntityModel: const OrderDto(),
      );

  @override
  Future<BaseResponse<OrderDto>> updateOrderStatus(UpdateOrderStatusRequest request) => _networkManager.request<OrderDto, OrderDto>(
        path: RequestPath.orderUpdateOrderStatus,
        type: RequestType.put,
        data: request,
        responseEntityModel: const OrderDto(),
      );
}
