import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/domain/sqflite_manager/sqflite_manager_repository.dart';
import 'package:flutter_core/flutter_core.dart';

extension FutureBaseResultExtension<T> on Future<BaseResult<T>> {
  Future<BaseResult<T>> intercept({
    bool showSuccessMessage = true,
    bool showErrorMessage = true,
  }) async {
    final sqfliteManagerRepository = getIt<ISqfliteManagerRepository>();

    final result = await this;

    if (result.error.isNull && showSuccessMessage) {
      sqfliteManagerRepository.addSuccessResult(result);
    } else if (result.error.isNotNull && showErrorMessage) {
      sqfliteManagerRepository.addErrorResult(result);
    }

    return result;
  }
}
