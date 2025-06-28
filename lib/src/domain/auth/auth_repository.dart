import 'dart:async';

import 'package:bloc_clean_architecture/src/common/blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/local/auth/auth_local_ds.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/auth_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/request/approve_agreement_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/forgot_password_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/login_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/refresh_token_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/register_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/send_otp_code_request.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_password_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/login_response.dart';
import 'package:bloc_clean_architecture/src/data/model/response/user_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

enum LicenseInformationStreamStatus { updateLicenseInformations }

abstract interface class IAuthRepository {
  void changeAuthState({required AuthState authState});
  void updateLicenseInformations();
  void dispose();

  Stream<AuthState> get status;
  Stream<LicenseInformationStreamStatus> get licenseInformationStream;

  /// Remote Data Source
  Future<BaseResponse<LoginResponse>> login({required LoginRequest request});
  Future<BaseResponse<LoginResponse>> refreshToken({required RefreshTokenRequest request});
  Future<BaseResponse<EmptyObject>> sendOtpCode({required SendOtpCodeRequest request});
  Future<BaseResponse<UserDto>> register({required RegisterRequest request});
  Future<BaseResponse<EmptyObject>> forgotPassword({required ForgotPasswordRequest request});
  Future<BaseResponse<EmptyObject>> updatePassword({required UpdatePasswordRequest request});
  Future<BaseResponse<EmptyObject>> approveAgreement({required ApproveAgreementRequest request});

  /// Shared Preferences
  LoginResponse? getUserCredentials();
  Future<bool> setUserCredentials({required LoginResponse userCredentials});
  Future<bool> deleteUserCredentials();
  String? getLoginPhoneCode();
  Future<bool> setLoginPhoneCode({required String phoneCode});
  Future<bool> deleteLoginPhoneCode();
  String? getLoginUsername();
  Future<bool> setLoginUsername({required String phone});
  Future<bool> deleteLoginUsername();
}

@LazySingleton(as: IAuthRepository)
final class AuthRepository implements IAuthRepository {
  AuthRepository(
    this._authRemoteDS,
    this._authLocalDS,
  );

  final IAuthRemoteDS _authRemoteDS;
  final IAuthLocalDS _authLocalDS;

  final _controller = StreamController<AuthState>.broadcast();
  final StreamController<LicenseInformationStreamStatus> _licenseInformationStreamController = StreamController<LicenseInformationStreamStatus>.broadcast();

  @override
  Stream<AuthState> get status async* {
    yield* _controller.stream;
  }

  @override
  Stream<LicenseInformationStreamStatus> get licenseInformationStream async* {
    yield* _licenseInformationStreamController.stream;
  }

  @override
  void changeAuthState({required AuthState authState}) {
    _controller.add(authState);
  }

  @override
  void updateLicenseInformations() {
    _licenseInformationStreamController.add(LicenseInformationStreamStatus.updateLicenseInformations);
  }

  @override
  void dispose() {
    _controller.close();
    _licenseInformationStreamController.close();
  }

  /// Remote Data Source

  @override
  Future<BaseResponse<EmptyObject>> forgotPassword({required ForgotPasswordRequest request}) => _authRemoteDS.forgotPassword(request: request);
  @override
  Future<BaseResponse<LoginResponse>> login({required LoginRequest request}) => _authRemoteDS.login(request: request);
  @override
  Future<BaseResponse<LoginResponse>> refreshToken({required RefreshTokenRequest request}) => _authRemoteDS.refreshToken(request: request);
  @override
  Future<BaseResponse<UserDto>> register({required RegisterRequest request}) => _authRemoteDS.register(request: request);
  @override
  Future<BaseResponse<EmptyObject>> sendOtpCode({required SendOtpCodeRequest request}) => _authRemoteDS.sendOtpCode(request: request);
  @override
  Future<BaseResponse<EmptyObject>> updatePassword({required UpdatePasswordRequest request}) => _authRemoteDS.updatePassword(request: request);
  @override
  Future<BaseResponse<EmptyObject>> approveAgreement({required ApproveAgreementRequest request}) => _authRemoteDS.approveAgreement(request: request);

  /// Shared Preferences
  @override
  LoginResponse? getUserCredentials() => _authLocalDS.getUserCredentials();
  @override
  Future<bool> setUserCredentials({required LoginResponse userCredentials}) => _authLocalDS.setUserCredentials(userCredentials: userCredentials);
  @override
  Future<bool> deleteUserCredentials() => _authLocalDS.deleteUserCredentials();
  @override
  String? getLoginPhoneCode() => _authLocalDS.getLoginPhoneCode();
  @override
  Future<bool> setLoginPhoneCode({required String phoneCode}) => _authLocalDS.setLoginPhoneCode(phoneCode: phoneCode);
  @override
  Future<bool> deleteLoginPhoneCode() => _authLocalDS.deleteLoginPhoneCode();
  @override
  String? getLoginUsername() => _authLocalDS.getLoginUsername();
  @override
  Future<bool> setLoginUsername({required String phone}) => _authLocalDS.setLoginUsername(phone: phone);
  @override
  Future<bool> deleteLoginUsername() => _authLocalDS.deleteLoginUsername();
}
