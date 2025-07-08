import 'dart:typed_data';

import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/file_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/response/file_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class IFileRepository {
  Future<BaseResponse<FileDto>> findById(int? id);
  Future<BaseResponse<Uint8List>> findByIdByte(int id);
  Future<BaseResponse<FileDto>> save(FormData formData);
  Future<BaseResponse<FileDto>> update(FormData formData);
  Future<BaseResponse<EmptyObject>> deleteById(int id);
}

@LazySingleton(as: IFileRepository)
final class FileRepository implements IFileRepository {
  const FileRepository(this._fileRemoteDS);

  final IFileRemoteDS _fileRemoteDS;

  @override
  Future<BaseResponse<FileDto>> findById(int? id) => _fileRemoteDS.findById(id);

  @override
  Future<BaseResponse<Uint8List>> findByIdByte(int id) => _fileRemoteDS.findByIdByte(id);

  @override
  Future<BaseResponse<FileDto>> save(FormData formData) => _fileRemoteDS.save(formData);

  @override
  Future<BaseResponse<FileDto>> update(FormData formData) => _fileRemoteDS.update(formData);

  @override
  Future<BaseResponse<EmptyObject>> deleteById(int id) => _fileRemoteDS.deleteById(id);
}
