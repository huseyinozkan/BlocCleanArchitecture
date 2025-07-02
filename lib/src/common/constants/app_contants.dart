import 'package:bloc_clean_architecture/src/common/enums/app_environment.dart';
import 'package:bloc_clean_architecture/src/common/enums/app_environment_extension.dart';
import 'package:bloc_clean_architecture/src/common/theme/color_scheme.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppConstants {
  static const general = General._();
  static const networkConstants = NetworkConstants._();
  static const configuration = Configuration._();

  static const paddingConstants = PaddingConstants._();
  static const applicationConfiguration = ApplicationConfiguration._();
  static const themeConstants = ThemeConstants._();
}

@immutable
final class General {
  const General._();

  int get passwordLength => 6;
  int get securityCodeLength => 6;
}

@immutable
final class NetworkConstants {
  const NetworkConstants._();

  String get baseUrl => AppEnvironment.selected.apiBaseUrl;
}

@immutable
final class Configuration {
  const Configuration._();

  bool get printBlocLogs => false;
}

@immutable
final class PaddingConstants {
  const PaddingConstants._();
  EdgeInsetsGeometry get pagePadding => const EdgeInsets.symmetric(horizontal: 23, vertical: 12);
  EdgeInsetsGeometry get pagePaddingHorizontal => const EdgeInsets.symmetric(horizontal: 20);
  EdgeInsetsGeometry get cardPadding => const EdgeInsets.all(16);
  EdgeInsetsGeometry get allLowPadding => const EdgeInsets.all(8);
  EdgeInsetsGeometry get allMediumPadding => const EdgeInsets.all(16);
  EdgeInsetsGeometry get allHighPadding => const EdgeInsets.all(20);
  EdgeInsetsGeometry get bottomLowPadding => const EdgeInsets.only(bottom: 8);
  EdgeInsetsGeometry get bottomMediumPadding => const EdgeInsets.only(bottom: 30);
  EdgeInsetsGeometry get bottomHighPadding => const EdgeInsets.only(bottom: 120);
  EdgeInsetsGeometry get leftPadding => const EdgeInsets.only(left: 16);
  EdgeInsetsGeometry get topPadding => const EdgeInsets.only(top: 16);
  EdgeInsetsGeometry pagePaddingSafe(BuildContext context) => pagePadding.add(EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom));
}

@immutable
final class ApplicationConfiguration {
  const ApplicationConfiguration._();
  String get androidPackageName => '';
  String get iOSAppId => '';
  String get huaweiAppId => '';
  bool get iosLaunchIntune => false;
}

@immutable
final class ThemeConstants {
  const ThemeConstants._();
  MyColorScheme get lightTheme => MyColorScheme(
        brightness: Brightness.light,
        primary: const Color(0xff0c6eff),
        primaryContainer: const Color.fromARGB(255, 125, 177, 254),
        onPrimary: Colors.white,
        secondary: const Color.fromARGB(255, 37, 37, 37),
        onSecondary: Colors.white,
        error: const Color(0xffe93e30),
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
        surfaceContainer: Colors.grey.shade200,
        surfaceDim: Colors.grey.shade300,
        scaffoldBackgroundColor: const Color(0xfff7f7f7),
        green: const Color(0xff568257),
        red: const Color(0xffae3c39),
        lightGray: const Color(0xfff4f4f4),
      );

  MyColorScheme get darkTheme => MyColorScheme(
        brightness: Brightness.dark,
        primary: const Color(0xff82b3ff),
        primaryContainer: const Color(0xff1a3d70),
        onPrimary: Colors.black,
        secondary: const Color.fromARGB(255, 59, 59, 59),
        onSecondary: Colors.black,
        error: const Color(0xffe93e30),
        onError: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white,
        surfaceContainer: Colors.grey.shade800,
        surfaceDim: Colors.grey.shade700,
        scaffoldBackgroundColor: const Color(0xff121212),
        green: const Color(0xff8AE68A),
        red: const Color(0xffFF8966),
        lightGray: const Color(0xff3f3f3f),
      );
}
