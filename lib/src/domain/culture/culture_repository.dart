import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/culture_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_culture_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_culture_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/culture_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class ICultureRepository {
  Future<BaseResponse<List<CultureDto>>> findAll();
  Future<BaseResponse<CultureDto>> findById({required int id});
  Future<BaseResponse<CultureDto>> save({required InsertCultureRequest request});
  Future<BaseResponse<CultureDto>> update({required UpdateCultureRequest request});
  Future<BaseResponse<EmptyObject>> deleteById({required int id});
}

@LazySingleton(as: ICultureRepository)
final class CultureRepository implements ICultureRepository {
  const CultureRepository(this._cultureRemoteDS);

  final CultureRemoteDS _cultureRemoteDS;

  @override
  Future<BaseResponse<List<CultureDto>>> findAll() => _cultureRemoteDS.findAll();

  @override
  Future<BaseResponse<CultureDto>> findById({required int id}) => _cultureRemoteDS.findById(id: id);

  @override
  Future<BaseResponse<CultureDto>> save({required InsertCultureRequest request}) => _cultureRemoteDS.save(request: request);

  @override
  Future<BaseResponse<CultureDto>> update({required UpdateCultureRequest request}) => _cultureRemoteDS.update(request: request);

  @override
  Future<BaseResponse<EmptyObject>> deleteById({required int id}) => _cultureRemoteDS.deleteById(id: id);
}
