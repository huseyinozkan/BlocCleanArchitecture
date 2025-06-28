import 'dart:async';

import 'package:bloc_clean_architecture/src/common/app_entry/app_entry.dart';
import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/observers/bloc_observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() {
  runZonedGuarded(
    () async {
      try {
        await preConfigure();
      } finally {
        runApp(const VeresiyeDefteriApp());
      }
    },
    (error, stack) {
      if (kReleaseMode) {
        // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }
    },
  );
}

Future<void> _initializeFirebase() async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// [instance] getter Firebase Analytics objesini oluşturur.
  // FirebaseAnalytics.instance
}

var _isConfigured = false;
Future<void> preConfigure({bool isTestMode = false}) async {
  if (_isConfigured) throw StateError("Tried to call preConfigure more than once. 'preConfigure()' is meant to be called only once in main.dart before runApp() or runZonedGuarded().");
  if (!isTestMode) WidgetsFlutterBinding.ensureInitialized();
  unawaited(
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  );
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await CorePathProvider.instance.getApplicationDocumentsDirectory(),
  );
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  await Future.wait([
    Core.initialize(),
    _initializeFirebase(),
  ]);
  _isConfigured = true;
}
