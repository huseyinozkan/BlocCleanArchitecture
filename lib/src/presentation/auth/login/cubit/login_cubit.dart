import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/agreement_type.dart';
import 'package:bloc_clean_architecture/src/data/model/request/login_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/register_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/agreement_dto.dart';
import 'package:bloc_clean_architecture/src/domain/agreement/agreement_repository.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
final class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository, this._popupManager, this._agreementRepository) : super(const LoginState());

  final IAuthRepository _authRepository;
  final IAgreementRepository _agreementRepository;
  final IMyPopupManager _popupManager;

  final loginFormKey = GlobalKey<FormState>();
  final loginUsernameController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();
  final registerPhoneCodeController = TextEditingController();
  final registerPhoneNumberController = TextEditingController();
  final registerNameController = TextEditingController();
  final registerSurnameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerUsernameController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerPasswordAgainController = TextEditingController();

  late final TabController tabController;
  AgreementDto? userAgreement;
  AgreementDto? privacyAgreement;

  void initialize({required TabController tabController}) {
    this.tabController = tabController;
    registerPhoneCodeController.text = _authRepository.getLoginPhoneCode() ?? '+90';
    loginUsernameController.text = _authRepository.getLoginUsername() ?? '';
  }

  void userAgreementValueChanged() {
    emit(state.copyWith(userAgreementValue: !state.userAgreementValue));
  }

  void confidentialityAgreementValueChanged() {
    emit(state.copyWith(privacyAgreementValue: !state.privacyAgreementValue));
  }

  Future<void> loginButtonClick() async {
    if (!(loginFormKey.currentState?.validate() ?? false)) return;

    final request = LoginRequest(
      username: loginUsernameController.text.trim(),
      password: loginPasswordController.text.trim(),
    );

    final response = await _authRepository.login(request: request).intercept(showSuccessMessage: false).withIndicator();
    if (response.isFailure) return;

    await Future.wait<void>([
      _authRepository.setLoginUsername(phone: loginUsernameController.text.trim()),
      _authRepository.setUserCredentials(userCredentials: response.data!),
    ]);

    _authRepository.changeAuthState(authState: AuthState.authenticated(userCredentials: response.data));
  }

  Future<void> registerButtonClick() async {
    if (!(registerFormKey.currentState?.validate() ?? false)) return;

    final request = RegisterRequest(
      name: registerNameController.text.trim(),
      surname: registerSurnameController.text.trim(),
      email: registerEmailController.text.trim(),
      username: registerUsernameController.text.trim(),
      phoneCode: registerPhoneCodeController.text.trim(),
      phoneNumber: registerPhoneNumberController.text.trim(),
      password: registerPasswordController.text.trim(),
    );

    final response = await _authRepository.register(request: request).intercept(showSuccessMessage: false).withIndicator();
    if (response.isFailure) return;

    tabController.animateTo(0);
    clearRegisterFields();
  }

  void clearRegisterFields() {
    registerPhoneNumberController.clear();
    registerNameController.clear();
    registerSurnameController.clear();
    registerEmailController.clear();
    registerUsernameController.clear();
    registerPasswordController.clear();
    registerPasswordAgainController.clear();
    registerFormKey.currentState?.reset();
  }

  Future<void> userAgreementButtonClick(BuildContext context) async {
    await _fetchCurrentAgreements();
    if (userAgreement.isNull) return;

    final value = !state.userAgreementValue;
    if (value && context.mounted) {
      final result = await _popupManager.bottomSheets.showWebContentBottomSheet(context, htmlContent: userAgreement?.content ?? '');
      if (result ?? false) userAgreementValueChanged();
      return;
    }

    userAgreementValueChanged();
  }

  Future<void> privacyAgreementButtonClick(BuildContext context) async {
    await _fetchCurrentAgreements();
    if (privacyAgreement.isNull) return;

    final value = !state.privacyAgreementValue;
    if (value && context.mounted) {
      final result = await _popupManager.bottomSheets.showWebContentBottomSheet(context, htmlContent: privacyAgreement?.content ?? '');
      if (result ?? false) confidentialityAgreementValueChanged();
      return;
    }

    confidentialityAgreementValueChanged();
  }

  Future<void> _fetchCurrentAgreements() async {
    final response = await _agreementRepository.currentAgreements().intercept(showSuccessMessage: false).withIndicator();
    userAgreement = response.data?.firstWhereOrNull((e) => e.type == AgreementType.userAgreement);
    privacyAgreement = response.data?.firstWhereOrNull((e) => e.type == AgreementType.privacyAgreement);
  }

  @override
  Future<void> close() {
    loginUsernameController.dispose();
    loginPasswordController.dispose();
    registerPhoneCodeController.dispose();
    registerPhoneNumberController.dispose();
    registerNameController.dispose();
    registerSurnameController.dispose();
    registerEmailController.dispose();
    registerUsernameController.dispose();
    registerPasswordController.dispose();
    registerPasswordAgainController.dispose();
    tabController.dispose();
    return super.close();
  }
}
