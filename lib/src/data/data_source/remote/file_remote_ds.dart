import 'dart:typed_data';

import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/file_type.dart';
import 'package:bloc_clean_architecture/src/data/model/response/file_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class IFileRemoteDS {
  Future<BaseResponse<FileDto>> findById(int id);
  Future<BaseResponse<Uint8List>> findByIdByte(int id);
  Future<BaseResponse<FileDto>> save(FileType fileType, Uint8List file);
  Future<BaseResponse<FileDto>> update(int id, FileType fileType, Uint8List file);
  Future<BaseResponse<EmptyObject>> deleteById(int id);
}

@LazySingleton(as: IFileRemoteDS)
final class FileRemoteDS implements IFileRemoteDS {
  const FileRemoteDS(this._networkManager);

  final NetworkManager _networkManager;

  @override
  Future<BaseResponse<FileDto>> findById(int id) => _networkManager.request<FileDto, FileDto>(
        path: RequestPath.file,
        type: RequestType.get,
        responseEntityModel: const FileDto(),
        pathSuffix: '/$id',
      );

  @override
  Future<BaseResponse<Uint8List>> findByIdByte(int id) => _networkManager.primitiveRequest<Uint8List>(
        path: RequestPath.fileByte,
        type: RequestType.get,
        pathSuffix: '/$id',
        responseType: ResponseType.bytes,
      );

  @override
  Future<BaseResponse<FileDto>> save(FileType fileType, Uint8List file) => _networkManager.request<FileDto, FileDto>(
        path: RequestPath.file,
        type: RequestType.post,
        responseEntityModel: const FileDto(),
        dioFormData: FormData.fromMap(
          {
            'fileType': fileType.value,
            'file': MultipartFile.fromBytes(file),
          },
        ),
      );

  @override
  Future<BaseResponse<FileDto>> update(int id, FileType fileType, Uint8List file) => _networkManager.request<FileDto, FileDto>(
        path: RequestPath.file,
        type: RequestType.put,
        responseEntityModel: const FileDto(),
        dioFormData: FormData.fromMap(
          {
            'id': id,
            'fileType': fileType.value,
            'file': MultipartFile.fromBytes(file),
          },
        ),
      );

  @override
  Future<BaseResponse<EmptyObject>> deleteById(int id) => _networkManager.request<EmptyObject, EmptyObject>(
        path: RequestPath.file,
        type: RequestType.delete,
        responseEntityModel: const EmptyObject(),
        pathSuffix: '/$id',
      );
}
