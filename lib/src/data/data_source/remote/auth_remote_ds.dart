import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
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

abstract interface class IAuthRemoteDS {
  Future<BaseResponse<LoginResponse>> login({required LoginRequest request});
  Future<BaseResponse<LoginResponse>> refreshToken({required RefreshTokenRequest request});
  Future<BaseResponse<EmptyObject>> sendOtpCode({required SendOtpCodeRequest request});
  Future<BaseResponse<UserDto>> register({required RegisterRequest request});
  Future<BaseResponse<EmptyObject>> forgotPassword({required ForgotPasswordRequest request});
  Future<BaseResponse<EmptyObject>> updatePassword({required UpdatePasswordRequest request});
  Future<BaseResponse<EmptyObject>> approveAgreement({required ApproveAgreementRequest request});
}

@LazySingleton(as: IAuthRemoteDS)
final class AuthRemoteDS implements IAuthRemoteDS {
  const AuthRemoteDS(this._networkManager);

  final NetworkManager _networkManager;

  @override
  Future<BaseResponse<LoginResponse>> login({required LoginRequest request}) {
    return _networkManager.request<LoginResponse, LoginResponse>(
      path: RequestPath.login,
      type: RequestType.post,
      responseEntityModel: const LoginResponse(),
      data: request,
    );
  }

  @override
  Future<BaseResponse<LoginResponse>> refreshToken({required RefreshTokenRequest request}) {
    return _networkManager.request<LoginResponse, LoginResponse>(
      path: RequestPath.refreshToken,
      type: RequestType.post,
      responseEntityModel: const LoginResponse(),
      data: request,
    );
  }

  @override
  Future<BaseResponse<EmptyObject>> sendOtpCode({required SendOtpCodeRequest request}) {
    return _networkManager.request<EmptyObject, EmptyObject>(
      path: RequestPath.sendOtpCode,
      type: RequestType.post,
      responseEntityModel: const EmptyObject(),
      data: request,
    );
  }

  @override
  Future<BaseResponse<UserDto>> register({required RegisterRequest request}) {
    return _networkManager.request<UserDto, UserDto>(
      path: RequestPath.register,
      type: RequestType.post,
      responseEntityModel: const UserDto(),
      data: request,
    );
  }

  @override
  Future<BaseResponse<EmptyObject>> forgotPassword({required ForgotPasswordRequest request}) {
    return _networkManager.request<EmptyObject, EmptyObject>(
      path: RequestPath.forgotPassword,
      type: RequestType.post,
      responseEntityModel: const EmptyObject(),
      data: request,
    );
  }

  @override
  Future<BaseResponse<EmptyObject>> updatePassword({required UpdatePasswordRequest request}) {
    return _networkManager.request<EmptyObject, EmptyObject>(
      path: RequestPath.updatePassword,
      type: RequestType.post,
      responseEntityModel: const EmptyObject(),
      data: request,
    );
  }

  @override
  Future<BaseResponse<EmptyObject>> approveAgreement({required ApproveAgreementRequest request}) {
    return _networkManager.request<EmptyObject, EmptyObject>(
      path: RequestPath.approveAgreements,
      type: RequestType.post,
      responseEntityModel: const EmptyObject(),
      data: request,
    );
  }
}
