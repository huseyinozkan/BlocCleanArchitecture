import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/cart_item_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_cart_item_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/cart_item_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class ICartItemRepository {
  Future<BaseResponse<List<CartItemDto>>> findAll();
  Future<BaseResponse<CartItemDto>> save(InsertCartItemRequest request);
  Future<BaseResponse<EmptyObject>> deleteById(int id);
  Future<BaseResponse<EmptyObject>> deleteAll();
}

@LazySingleton(as: ICartItemRepository)
final class CartItemRepository implements ICartItemRepository {
  const CartItemRepository(this._cartItemRemoteDS);

  final ICartItemRemoteDS _cartItemRemoteDS;

  @override
  Future<BaseResponse<List<CartItemDto>>> findAll() => _cartItemRemoteDS.findAll();

  @override
  Future<BaseResponse<CartItemDto>> save(InsertCartItemRequest request) => _cartItemRemoteDS.save(request);

  @override
  Future<BaseResponse<EmptyObject>> deleteById(int id) => _cartItemRemoteDS.deleteById(id);

  @override
  Future<BaseResponse<EmptyObject>> deleteAll() => _cartItemRemoteDS.deleteAll();
}
