import 'package:bloc_clean_architecture/src/common/blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/common/blocs/indicator/bloc/indicator_bloc.dart';
import 'package:bloc_clean_architecture/src/common/blocs/network_manager/bloc/network_manager_bloc.dart';
import 'package:bloc_clean_architecture/src/common/blocs/sqflite_manager/bloc/sqflite_manager_bloc.dart';
import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/overlay_manager/overlay_manager.dart';
import 'package:bloc_clean_architecture/src/common/overlay_manager/toast_type.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class AppEntryMultiBlocListener extends StatelessWidget {
  AppEntryMultiBlocListener({required this.builder, super.key});

  final WidgetBuilder builder;

  final routerService = getIt<IMyRouterService>();
  final rootNavigatorKey = getIt<IMyRouterService>().rootNavigatorKey;
  final popupManager = getIt<IMyPopupManager>();
  final overlayManager = getIt<IMyOverlayManager>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        _networkManagerBlocListener(),
        _indicatorBlocListener(),
        _authBlocListener(),
        _sqfliteManagerBlocListener(),
      ],
      child: Builder(builder: builder),
    );
  }

  BlocListener<NetworkManagerBloc, NetworkManagerState> _networkManagerBlocListener() {
    return BlocListener<NetworkManagerBloc, NetworkManagerState>(
      listener: (context, state) {
        if (rootNavigatorKey.currentContext == null) return;
        if (state.baseResponse == null) return;
        if (state.baseResponse?.statusCode == 503) return; // ServiceUnavailableBloc will handle this
        final baseResponse = state.baseResponse!;

        if (state is NetworkManagerSuccess && (baseResponse.messages.isNotNullAndNotEmpty)) {
          getIt<IMyOverlayManager>().showToast(message: baseResponse.messages!.join('\n'), type: ToastType.success);
        } else if (state is NetworkManagerError) {
          List<String>? errorMessages;
          if (state.baseResponse?.error is DioException) {
            final creatingErrorMessageFromDioException = CreatingErrorMessageFromDioException(state.baseResponse!.error! as DioException);
            errorMessages = [creatingErrorMessageFromDioException.message];
          }

          final messages = baseResponse.messages ?? errorMessages ?? [LocalizationKey.unknownErrorOccured.tr(context)];
          popupManager.dialogs.showErrorDialog(context: context, message: messages.join('\n'));
        }
      },
    );
  }

  BlocListener<IndicatorBloc, IndicatorState> _indicatorBlocListener() {
    return BlocListener<IndicatorBloc, IndicatorState>(
      listener: (context, state) {
        if (state is IndicatorShow) {
          popupManager.dialogs.showLoader(context: context, id: state.indicatorKey);
        } else if (state is IndicatorHide) {
          popupManager.dialogs.hidePopup<void>(id: state.indicatorKey);
        }
      },
    );
  }

  BlocListener<AuthBloc, AuthState> _authBlocListener() {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthenticationStatus.unAuthenticated) {
          routerService.rootRouter.refresh();
        } else if (state.status == AuthenticationStatus.authenticated) {
          routerService.rootRouter.goNamed(RoutePaths.products.name);
        }
      },
    );
  }

  BlocListener<SqfliteManagerBloc, SqfliteManagerState> _sqfliteManagerBlocListener() {
    return BlocListener<SqfliteManagerBloc, SqfliteManagerState>(
      listener: (context, state) {
        if (rootNavigatorKey.currentContext == null) return;
        if (state.baseResult == null) return;
        final baseResult = state.baseResult!;

        if (state is SqfliteManagerSuccess) {
          overlayManager.showToast(message: LocalizationKey.operationSuccessful.tr(context, listen: false));
        } else if (state is SqfliteManagerError) {
          overlayManager.showToast(message: baseResult.error?.toString() ?? LocalizationKey.unknownErrorOccured.tr(context, listen: false), type: ToastType.error);
        }
      },
    );
  }
}
