import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_product_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_product_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/product_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class IProductRemoteDS {
  Future<BaseResponse<List<ProductDto>>> findAll();
  Future<BaseResponse<List<ProductDto>>> findAllByCategoryId(int id);
  Future<BaseResponse<ProductDto>> findById(int? id);
  Future<BaseResponse<ProductDto>> save(InsertProductRequest request);
  Future<BaseResponse<ProductDto>> update(UpdateProductRequest request);
  Future<BaseResponse<EmptyObject>> deleteById(int? id);
}

@LazySingleton(as: IProductRemoteDS)
final class ProductRemoteDS implements IProductRemoteDS {
  const ProductRemoteDS(this._networkManager);

  final NetworkManager _networkManager;

  @override
  Future<BaseResponse<List<ProductDto>>> findAll() => _networkManager.request<List<ProductDto>, ProductDto>(
        path: RequestPath.product,
        type: RequestType.get,
        responseEntityModel: const ProductDto(),
      );

  @override
  Future<BaseResponse<List<ProductDto>>> findAllByCategoryId(int id) => _networkManager.request<List<ProductDto>, ProductDto>(
        path: RequestPath.productByCategoryId,
        type: RequestType.get,
        responseEntityModel: const ProductDto(),
        pathSuffix: '/$id',
      );

  @override
  Future<BaseResponse<ProductDto>> findById(int? id) => _networkManager.request<ProductDto, ProductDto>(
        path: RequestPath.product,
        type: RequestType.get,
        responseEntityModel: const ProductDto(),
        pathSuffix: '/$id',
      );

  @override
  Future<BaseResponse<ProductDto>> save(InsertProductRequest request) => _networkManager.request<ProductDto, ProductDto>(
        path: RequestPath.product,
        type: RequestType.post,
        data: request,
        responseEntityModel: const ProductDto(),
      );

  @override
  Future<BaseResponse<ProductDto>> update(UpdateProductRequest request) => _networkManager.request<ProductDto, ProductDto>(
        path: RequestPath.product,
        type: RequestType.put,
        data: request,
        responseEntityModel: const ProductDto(),
      );

  @override
  Future<BaseResponse<EmptyObject>> deleteById(int? id) => _networkManager.request<EmptyObject, EmptyObject>(
        path: RequestPath.product,
        type: RequestType.delete,
        responseEntityModel: const EmptyObject(),
        pathSuffix: '/$id',
      );
}
