import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:bloc_clean_architecture/src/domain/splash/splash_repository.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/splash/retriables/localization_retriable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@injectable
final class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(
    this._authRepository,
    this._splashRepository,
    // this._popupManager,
    // this._routerService,
  ) : super(const SplashInitial()) {
    on<SplashInitializedEvent>(_splashInitializedEvent);
  }

  final IAuthRepository _authRepository;
  final ISplashRepository _splashRepository;
  // final IMyPopupManager _popupManager;
  // final IMyRouterService _routerService;

  // Retriables
  // final _remoteConfigRetriable = RemoteConfigRetriable();
  // final _versionControlRetriable = VersionControlRetriable(maxRetries: 1);
  final _localizationRetriable = LocalizationRetriable();

  // Initializes Splash Logic
  Future<void> _splashInitializedEvent(SplashInitializedEvent event, Emitter<SplashState> emit) async {
    try {
      // Splash'da bekleme süresi
      await 300.milliseconds.delay<void>();

      // Remote Config başlatılır.
      await _initializeRemoteConfig();

      // Versiyon kontrolü yapılır.
      await _versionControl();

      // SharedPrefences ve Sqflite veritabanı başlatılır.
      await _initializeLocalDB();

      // Lokal dil dosyaları yüklenir.
      await _getLocalizations();

      // Auth state başlatılır.
      _initializeAuthState();
      // } on FirebaseException catch (e) {
      //   emit(SplashError(e.message ?? e.toString()));
    } catch (e) {
      emit(SplashError(e.toString()));
    }
  }

  Future<void> _initializeRemoteConfig() {
    // return _remoteConfigRetriable.execute();
    return Future.value();
  }

  Future<void> _versionControl() async {
    // final hasForceUpdate = await _versionControlRetriable.execute();
    // if (hasForceUpdate.isNull) return;

    // final context = _routerService.rootNavigatorKey.currentState?.context;
    // if (context?.mounted ?? false) {
    //   await _popupManager.base.showUpdateAvailableDialog(
    //     isForceUpdate: hasForceUpdate!,
    //     androidPackageName: AppConstants.applicationConfiguration.androidPackageName,
    //   );
    // }
  }

  Future<void> _initializeLocalDB() {
    return _splashRepository.initializeLocalDB();
  }

  Future<bool> _getLocalizations() {
    return _localizationRetriable.execute();
  }

  void _initializeAuthState() {
    final userCredentials = _authRepository.getUserCredentials();

    if (userCredentials.isNotNull) {
      _authRepository.changeAuthState(
        authState: AuthState.authenticated(
          userCredentials: userCredentials,
        ),
      );
    } else {
      _authRepository.changeAuthState(
        authState: const AuthState.unAuthenticated(),
      );
    }
  }
}
