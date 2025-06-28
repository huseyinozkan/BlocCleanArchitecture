import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/agreement_type.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/role_type.dart';
import 'package:bloc_clean_architecture/src/data/model/request/agreement_id_and_type.dart';
import 'package:bloc_clean_architecture/src/data/model/request/approve_agreement_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/agreement_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/login_response.dart';
import 'package:bloc_clean_architecture/src/domain/agreement/agreement_repository.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@injectable
final class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._authRepository, this._agreementRepository, this._popupManager) : super(const HomeState());
  final IAuthRepository _authRepository;
  final IAgreementRepository _agreementRepository;
  final IMyPopupManager _popupManager;

  TextEditingController searchController = TextEditingController();

  AgreementDto? userAgreement;
  AgreementDto? privacyAgreement;

  LoginResponse? get loginResponse => _authRepository.getUserCredentials();

  bool get isAdmin => loginResponse?.user?.roles?.any((role) => role.name == RoleType.roleAdmin) ?? false;

  Future<void> initialized(BuildContext context) async {
    unawaited(checkAgreements(context));
    emit(state.copyWith(status: HomeStatus.loaded));
  }

  Future<void> checkAgreements(BuildContext context) async {
    final loginResponse = _authRepository.getUserCredentials();
    final agreementIdAndTypes = <AgreementIdAndType>[];

    if (loginResponse?.privacyAgreementHasBeenApproved == false) {
      await _fetchCurrentAgreements();
      final result = await _popupManager.bottomSheets.showWebContentBottomSheet(context, htmlContent: privacyAgreement?.content ?? '');
      if (result ?? false) agreementIdAndTypes.add(AgreementIdAndType(id: privacyAgreement?.id, type: AgreementType.privacyAgreement));
    }

    if (loginResponse?.userAgreementHasBeenApproved == false) {
      await _fetchCurrentAgreements();
      final result = await _popupManager.bottomSheets.showWebContentBottomSheet(context, htmlContent: userAgreement?.content ?? '');
      if (result ?? false) agreementIdAndTypes.add(AgreementIdAndType(id: userAgreement?.id, type: AgreementType.userAgreement));
    }

    if (agreementIdAndTypes.isEmpty) return;

    await _authRepository.approveAgreement(request: ApproveAgreementRequest(agreements: agreementIdAndTypes));
  }

  Future<void> _fetchCurrentAgreements() async {
    final response = await _agreementRepository.currentAgreements().intercept(showSuccessMessage: false).withIndicator();
    userAgreement = response.data?.firstWhereOrNull((element) => element.type == AgreementType.userAgreement);
    privacyAgreement = response.data?.firstWhereOrNull((element) => element.type == AgreementType.privacyAgreement);
  }

  void signOut() {
    _authRepository
      ..deleteUserCredentials()
      ..changeAuthState(authState: const AuthState.unAuthenticated());
  }
}
