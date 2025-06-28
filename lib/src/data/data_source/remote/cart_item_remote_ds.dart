import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_cart_item_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/cart_item_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class ICartItemRemoteDS {
  Future<BaseResponse<List<CartItemDto>>> findAll();
  Future<BaseResponse<CartItemDto>> save(InsertCartItemRequest request);
  Future<BaseResponse<EmptyObject>> deleteById(int id);
  Future<BaseResponse<EmptyObject>> deleteAll();
}

@LazySingleton(as: ICartItemRemoteDS)
final class CartItemRemoteDS implements ICartItemRemoteDS {
  const CartItemRemoteDS(this._networkManager);

  final NetworkManager _networkManager;

  @override
  Future<BaseResponse<List<CartItemDto>>> findAll() => _networkManager.request<List<CartItemDto>, CartItemDto>(
        path: RequestPath.cartItem,
        type: RequestType.get,
        responseEntityModel: const CartItemDto(),
      );

  @override
  Future<BaseResponse<CartItemDto>> save(InsertCartItemRequest request) => _networkManager.request<CartItemDto, CartItemDto>(
        path: RequestPath.cartItem,
        type: RequestType.post,
        data: request,
        responseEntityModel: const CartItemDto(),
      );

  @override
  Future<BaseResponse<EmptyObject>> deleteById(int id) => _networkManager.request<EmptyObject, EmptyObject>(
        path: RequestPath.cartItem,
        type: RequestType.delete,
        responseEntityModel: const EmptyObject(),
        pathSuffix: '/$id',
      );

  @override
  Future<BaseResponse<EmptyObject>> deleteAll() => _networkManager.request<EmptyObject, EmptyObject>(
        path: RequestPath.cartItemDeleteAll,
        type: RequestType.delete,
        responseEntityModel: const EmptyObject(),
      );
}
