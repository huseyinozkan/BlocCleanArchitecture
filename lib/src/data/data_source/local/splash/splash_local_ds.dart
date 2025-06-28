import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_prefences_manager.dart';
import 'package:bloc_clean_architecture/src/common/sqflite_manager/sqflite_manager.dart';
import 'package:injectable/injectable.dart';

abstract interface class ISplashLocalDS {
  Future<void> initializeSqfLite();
  Future<void> initializeSharedPreferences();
}

@LazySingleton(as: ISplashLocalDS)
final class SplashLocalDS implements ISplashLocalDS {
  SplashLocalDS(this._sqfliteManager, this._pref);

  final SqfliteManager _sqfliteManager;
  final SharedPreferencesManager _pref;

  @override
  Future<void> initializeSqfLite() => _sqfliteManager.openDB();

  @override
  Future<void> initializeSharedPreferences() => _pref.initialize();
}
