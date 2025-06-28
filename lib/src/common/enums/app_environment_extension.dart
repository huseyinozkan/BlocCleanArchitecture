import 'package:bloc_clean_architecture/src/common/constants/env.dart';
import 'package:bloc_clean_architecture/src/common/enums/app_environment.dart';

extension AppEnvironmentExtension on AppEnvironment {
  String get apiBaseUrl => switch (this) {
        AppEnvironment.dev => Env.apiUrlDev,
        AppEnvironment.prod => Env.apiUrlProd,
      };
}
