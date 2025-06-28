import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/data/model/request/forgot_password_request.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/forgot_password/view/forgot_password_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'forgot_password_state.dart';

@injectable
final class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._authRepository, this._routerService) : super(const ForgotPasswordState());

  final IAuthRepository _authRepository;
  final IMyRouterService _routerService;
  late final ForgotPasswordArguments arguments;

  final formKey = GlobalKey<FormState>();

  final securityCodeController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();

  Future<void> nextButtonClick() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final request = ForgotPasswordRequest(
      phoneCode: arguments.phoneCode,
      phoneNumber: arguments.phoneNumber,
      code: securityCodeController.text.trim(),
      newPassword: passwordController.text.trim(),
    );

    final response = await _authRepository.forgotPassword(request: request).intercept().withIndicator();
    if (response.isFailure) return;

    unawaited(_routerService.rootRouter.pushReplacementNamed(RoutePaths.login.name));
  }

  @override
  Future<void> close() {
    securityCodeController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
    return super.close();
  }
}
