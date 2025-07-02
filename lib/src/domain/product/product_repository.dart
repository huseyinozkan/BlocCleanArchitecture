import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/product_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_product_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_product_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/product_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class IProductRepository {
  Future<BaseResponse<List<ProductDto>>> findAll();
  Future<BaseResponse<List<ProductDto>>> findAllByCategoryId(int id);
  Future<BaseResponse<ProductDto>> findById(int id);
  Future<BaseResponse<ProductDto>> save(InsertProductRequest request);
  Future<BaseResponse<ProductDto>> update(UpdateProductRequest request);
  Future<BaseResponse<EmptyObject>> deleteById(int id);
}

@LazySingleton(as: IProductRepository)
final class ProductRepository implements IProductRepository {
  const ProductRepository(this._productRemoteDS);

  final IProductRemoteDS _productRemoteDS;

  @override
  Future<BaseResponse<List<ProductDto>>> findAll() => _productRemoteDS.findAll();

  @override
  Future<BaseResponse<List<ProductDto>>> findAllByCategoryId(int id) => _productRemoteDS.findAllByCategoryId(id);

  @override
  Future<BaseResponse<ProductDto>> findById(int id) => _productRemoteDS.findById(id);

  @override
  Future<BaseResponse<ProductDto>> save(InsertProductRequest request) => _productRemoteDS.save(request);

  @override
  Future<BaseResponse<ProductDto>> update(UpdateProductRequest request) => _productRemoteDS.update(request);

  @override
  Future<BaseResponse<EmptyObject>> deleteById(int id) => _productRemoteDS.deleteById(id);
}
