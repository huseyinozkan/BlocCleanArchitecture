import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/order_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_order_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_order_status_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/order_dto.dart';
import 'package:injectable/injectable.dart';

abstract interface class IOrderRepository {
  Future<BaseResponse<List<OrderDto>>> findAll();
  Future<BaseResponse<List<OrderDto>>> findAllAdmin();
  Future<BaseResponse<List<OrderDto>>> findAllAdminByOrderStatus(OrderStatus orderStatus);
  Future<BaseResponse<OrderDto>> findById(int? id);
  Future<BaseResponse<OrderDto>> save(InsertOrderRequest request);
  Future<BaseResponse<OrderDto>> updateOrderStatus(UpdateOrderStatusRequest request);
}

@LazySingleton(as: IOrderRepository)
final class OrderRepository implements IOrderRepository {
  const OrderRepository(this._orderRemoteDS);

  final IOrderRemoteDS _orderRemoteDS;

  @override
  Future<BaseResponse<List<OrderDto>>> findAll() => _orderRemoteDS.findAll();

  @override
  Future<BaseResponse<List<OrderDto>>> findAllAdmin() => _orderRemoteDS.findAllAdmin();

  @override
  Future<BaseResponse<List<OrderDto>>> findAllAdminByOrderStatus(OrderStatus orderStatus) => _orderRemoteDS.findAllAdminByOrderStatus(orderStatus);

  @override
  Future<BaseResponse<OrderDto>> findById(int? id) => _orderRemoteDS.findById(id);

  @override
  Future<BaseResponse<OrderDto>> save(InsertOrderRequest request) => _orderRemoteDS.save(request);

  @override
  Future<BaseResponse<OrderDto>> updateOrderStatus(UpdateOrderStatusRequest request) => _orderRemoteDS.updateOrderStatus(request);
}
