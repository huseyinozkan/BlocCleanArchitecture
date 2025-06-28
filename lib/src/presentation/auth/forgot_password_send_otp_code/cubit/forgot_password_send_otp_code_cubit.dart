import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/otp_purpose.dart';
import 'package:bloc_clean_architecture/src/data/model/request/send_otp_code_request.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/forgot_password/view/forgot_password_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'forgot_password_send_otp_code_state.dart';

@injectable
final class ForgotPasswordSendOtpCodeCubit extends Cubit<ForgotPasswordSendOtpCodeState> {
  ForgotPasswordSendOtpCodeCubit(this._authRepository, this._routerService) : super(const ForgotPasswordSendOtpCodeState());

  final IAuthRepository _authRepository;
  final IMyRouterService _routerService;
  final formKey = GlobalKey<FormState>();
  final phoneCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();

  void initialize() {
    phoneCodeController.text = _authRepository.getLoginPhoneCode() ?? '+90';
  }

  Future<void> nextButtonClick() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final request = SendOtpCodeRequest(
      phoneCode: phoneCodeController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      purpose: OtpPurpose.forgotPassword,
    );

    final response = await _authRepository.sendOtpCode(request: request).intercept(showSuccessMessage: false).withIndicator();
    if (response.isFailure) return;

    final extra = ForgotPasswordArguments(phoneCode: phoneCodeController.text.trim(), phoneNumber: phoneNumberController.text.trim());
    unawaited(_routerService.rootRouter.pushReplacementNamed(RoutePaths.forgotPassword.name, extra: extra));
  }

  @override
  Future<void> close() {
    phoneCodeController.dispose();
    phoneNumberController.dispose();
    return super.close();
  }
}
