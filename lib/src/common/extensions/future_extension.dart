import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/domain/indicator/indicator_repository.dart';
import 'package:flutter_core/flutter_core.dart';

extension FutureExtension<T> on Future<T> {
  Future<T> withIndicator() async {
    final indicatorRepository = getIt<IIndicatorRepository>();

    try {
      indicatorRepository.show();
      final result = await this;
      indicatorRepository.hide();
      await 200.milliseconds.delay<void>();
      return result;
    } catch (e) {
      indicatorRepository.hide();
      await 200.milliseconds.delay<void>();
      rethrow;
    }
  }
}
