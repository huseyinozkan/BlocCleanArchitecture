import 'package:bloc_clean_architecture/src/data/data_source/local/splash/splash_local_ds.dart';
import 'package:injectable/injectable.dart';

abstract interface class ISplashRepository {
  Future<void> initializeLocalDB();
}

@LazySingleton(as: ISplashRepository)
final class SplashRepository implements ISplashRepository {
  SplashRepository(this._splashLocalDS);

  final ISplashLocalDS _splashLocalDS;

  @override
  Future<void> initializeLocalDB() {
    return Future.wait(
      [
        _splashLocalDS.initializeSharedPreferences(),
        _splashLocalDS.initializeSqfLite(),
      ],
      eagerError: true,
    );
  }
}
