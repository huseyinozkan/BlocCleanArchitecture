import 'dart:async';

import 'package:bloc_clean_architecture/src/common/blocs/sqflite_manager/bloc/sqflite_manager_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class ISqfliteManagerRepository {
  void addSuccessResult(BaseResult<dynamic> baseResult);

  void addErrorResult(BaseResult<dynamic> baseResult);

  Stream<SqfliteManagerState> get status;
}

@LazySingleton(as: ISqfliteManagerRepository)
final class SqfliteManagerRepository extends ISqfliteManagerRepository {
  final _controller = StreamController<SqfliteManagerState>.broadcast();

  @override
  Stream<SqfliteManagerState> get status async* {
    yield* _controller.stream;
  }

  @override
  void addSuccessResult(BaseResult<dynamic> baseResult) => _controller.add(SqfliteManagerSuccess(baseResult: baseResult));

  @override
  void addErrorResult(BaseResult<dynamic> baseResult) => _controller.add(SqfliteManagerError(baseResult: baseResult));

  void dispose() => _controller.close();
}
