import 'package:bloc_clean_architecture/src/common/blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/common/functions/functions.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/presentation/admin/view/admin_view.dart';
import 'package:bloc_clean_architecture/src/presentation/app_settings/view/app_settings_view.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/forgot_password/view/forgot_password_view.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/forgot_password_send_otp_code/view/forgot_password_send_otp_code_view.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/login/view/login_view.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/splash/view/splash_view.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/update_password/view/update_password_view.dart';
import 'package:bloc_clean_architecture/src/presentation/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

abstract interface class IMyRouterService {
  GlobalKey<NavigatorState> get rootNavigatorKey;
  GoRouter get rootRouter;
}

@LazySingleton(as: IMyRouterService)
final class MyRouterService implements IMyRouterService {
  @override
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  @override
  GoRouter get rootRouter => _rootRouter;

  late final _rootRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    observers: [
      //FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
    routes: [
      /// Splash route
      GoRoute(
        path: RoutePaths.splash.asRoutePath,
        name: RoutePaths.splash.name,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: SplashView(),
          );
        },
      ),

      /// Login route
      GoRoute(
        path: RoutePaths.login.asRoutePath,
        name: RoutePaths.login.name,
        builder: (context, state) => const LoginView(),
        routes: [
          /// Forgot Password Send OTP Code route
          GoRoute(
            path: RoutePaths.forgotPassswordSendOtpCode.asRoutePath,
            name: RoutePaths.forgotPassswordSendOtpCode.name,
            builder: (context, state) => const ForgotPasswordSendOtpCodeView(),
          ),

          /// Forgot Password route
          GoRoute(
            path: RoutePaths.forgotPassword.asRoutePath,
            name: RoutePaths.forgotPassword.name,
            builder: (context, state) => ForgotPasswordView(arguments: state.extra! as ForgotPasswordArguments),
          ),
        ],
      ),

      /// Home route
      GoRoute(
        path: RoutePaths.home.asRoutePath,
        name: RoutePaths.home.name,
        builder: (context, state) => const HomeView(),
        routes: [
          // App Settings route
          GoRoute(
            path: RoutePaths.appSettings.asRoutePath,
            name: RoutePaths.appSettings.name,
            builder: (context, state) => const AppSettingsView(),
          ),

          // User Informations route
          GoRoute(
            path: RoutePaths.updatePassword.asRoutePath,
            name: RoutePaths.updatePassword.name,
            builder: (context, state) => const UpdatePasswordView(),
          ),

          // Admin route
          GoRoute(
            path: RoutePaths.admin.asRoutePath,
            name: RoutePaths.admin.name,
            builder: (context, state) => const AdminView(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authenticationStatus = context.read<AuthBloc>().state.status;

      if (authenticationStatus == AuthenticationStatus.unAuthenticated) {
        final routePath = MyFunctions.convertFullPathToEnum(state.fullPath);
        final isAuthRequired = routePath?.isAuthRequired ?? false;
        if (routePath == RoutePaths.splash || isAuthRequired) return RoutePaths.login.asRoutePath;
      }

      return null;
    },
    debugLogDiagnostics: true,
  );
}
