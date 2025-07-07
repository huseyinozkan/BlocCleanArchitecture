import 'package:bloc_clean_architecture/src/common/blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/common/functions/functions.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/presentation/account/account/view/account_view.dart';
import 'package:bloc_clean_architecture/src/presentation/account/address/address_detail/view/address_detail_view.dart';
import 'package:bloc_clean_architecture/src/presentation/account/address/addresses/view/address_view.dart';
import 'package:bloc_clean_architecture/src/presentation/account/admin/admin_operations/view/admin_operations_view.dart';
import 'package:bloc_clean_architecture/src/presentation/account/admin/admin_orders/view/admin_orders_view.dart';
import 'package:bloc_clean_architecture/src/presentation/account/admin/categories/categories/view/categories_view.dart';
import 'package:bloc_clean_architecture/src/presentation/account/admin/categories/category_detail/view/category_detail_view.dart';
import 'package:bloc_clean_architecture/src/presentation/account/past_orders/cubit/view/bottom_navigation_bar_view.dart';
import 'package:bloc_clean_architecture/src/presentation/account/past_orders/view/past_orders_view.dart';
import 'package:bloc_clean_architecture/src/presentation/account/settings/view/settings_view.dart';
import 'package:bloc_clean_architecture/src/presentation/account/update_password/view/update_password_view.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/forgot_password/view/forgot_password_view.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/forgot_password_send_otp_code/view/forgot_password_send_otp_code_view.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/login/view/login_view.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/splash/view/splash_view.dart';
import 'package:bloc_clean_architecture/src/presentation/cart/cart/view/cart_view.dart';
import 'package:bloc_clean_architecture/src/presentation/cart/order/view/order_view.dart';
import 'package:bloc_clean_architecture/src/presentation/products/view/products_view.dart';
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

  final _sectionProductsNavigatorKey = GlobalKey<NavigatorState>();
  final _sectionAccountNavigatorKey = GlobalKey<NavigatorState>();
  final _sectionCartNavigatorKey = GlobalKey<NavigatorState>();

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

      /// Bottom navigation bar route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => BottomNavigationBarView(navigationShell: navigationShell),
        branches: [
          /// Products
          StatefulShellBranch(
            navigatorKey: _sectionProductsNavigatorKey,
            routes: [
              /// Products route
              GoRoute(
                path: RoutePaths.products.asRoutePath,
                name: RoutePaths.products.name,
                builder: (context, state) => const ProductsView(),
              ),
            ],
          ),

          /// Account
          StatefulShellBranch(
            navigatorKey: _sectionAccountNavigatorKey,
            routes: [
              /// Account route
              GoRoute(
                path: RoutePaths.account.asRoutePath,
                name: RoutePaths.account.name,
                builder: (context, state) => const AccountView(),
                routes: [
                  /// Admin Operations route
                  GoRoute(
                    parentNavigatorKey: rootNavigatorKey,
                    path: RoutePaths.adminOperations.asRoutePath,
                    name: RoutePaths.adminOperations.name,
                    builder: (context, state) => const AdminOperationsView(),
                    routes: [
                      /// Admin Orders route
                      GoRoute(
                        parentNavigatorKey: rootNavigatorKey,
                        path: RoutePaths.adminOrders.asRoutePath,
                        name: RoutePaths.adminOrders.name,
                        builder: (context, state) => const AdminOrdersView(),
                      ),

                      /// Categories route
                      GoRoute(
                        parentNavigatorKey: rootNavigatorKey,
                        path: RoutePaths.categories.asRoutePath,
                        name: RoutePaths.categories.name,
                        builder: (context, state) => const CategoriesView(),
                        routes: [
                          /// Category Detail route
                          GoRoute(
                            parentNavigatorKey: rootNavigatorKey,
                            path: RoutePaths.categoryDetail.asRoutePath,
                            name: RoutePaths.categoryDetail.name,
                            builder: (context, state) => CategoryDetailView(arguments: state.extra as CategoryDetailArguments?),
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// Settings route
                  GoRoute(
                    parentNavigatorKey: rootNavigatorKey,
                    path: RoutePaths.settings.asRoutePath,
                    name: RoutePaths.settings.name,
                    builder: (context, state) => const SettingsView(),
                  ),

                  /// Update Password route
                  GoRoute(
                    parentNavigatorKey: rootNavigatorKey,
                    path: RoutePaths.updatePassword.asRoutePath,
                    name: RoutePaths.updatePassword.name,
                    builder: (context, state) => const UpdatePasswordView(),
                  ),

                  /// Addresses route
                  GoRoute(
                    parentNavigatorKey: rootNavigatorKey,
                    path: RoutePaths.addresses.asRoutePath,
                    name: RoutePaths.addresses.name,
                    builder: (context, state) => const AddressView(),
                    routes: [
                      /// Address Detail route
                      GoRoute(
                        parentNavigatorKey: rootNavigatorKey,
                        path: RoutePaths.addressDetail.asRoutePath,
                        name: RoutePaths.addressDetail.name,
                        builder: (context, state) => AddressDetailView(arguments: state.extra as AddressDetailArguments?),
                      ),
                    ],
                  ),

                  /// Past Orders route
                  GoRoute(
                    parentNavigatorKey: rootNavigatorKey,
                    path: RoutePaths.pastOrders.asRoutePath,
                    name: RoutePaths.pastOrders.name,
                    builder: (context, state) => const PastOrdersView(),
                  ),
                ],
              ),
            ],
          ),

          /// Cart
          StatefulShellBranch(
            navigatorKey: _sectionCartNavigatorKey,
            routes: [
              /// Cart route
              GoRoute(
                path: RoutePaths.cart.asRoutePath,
                name: RoutePaths.cart.name,
                builder: (context, state) => const CartView(),
                routes: [
                  /// Order route
                  GoRoute(
                    parentNavigatorKey: rootNavigatorKey,
                    path: RoutePaths.order.asRoutePath,
                    name: RoutePaths.order.name,
                    builder: (context, state) => const OrderView(),
                  ),
                ],
              ),
            ],
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
