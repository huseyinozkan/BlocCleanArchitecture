import 'dart:io';

import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/data/model/request/refresh_token_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/login_response.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:flutter_core/flutter_core.dart';

final class RefreshTokenInterceptor extends InterceptorsWrapper {
  RefreshTokenInterceptor();

  NetworkManager get networkManager => getIt<NetworkManager>();
  IAuthRepository get authRepository => getIt<IAuthRepository>();

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !err.requestOptions.path.contains(RequestPath.refreshToken.value) && !err.requestOptions.path.contains(RequestPath.login.value)) {
      final newAccessToken = await newAccessTokenCallback();
      if (newAccessToken.isNotNull) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        return handler.resolve(await Dio(networkManager.baseOptions).fetch(err.requestOptions));
      }
    }

    return handler.next(err);
  }

  Future<String?> newAccessTokenCallback() async {
    final refreshToken = authRepository.getUserCredentials()?.refreshToken;
    if (refreshToken.isNull) return null;
    String? language() => getIt<IMyRouterService>().rootNavigatorKey.currentContext?.locale.toString();
    final response = await networkManager.request<LoginResponse, LoginResponse>(
      path: RequestPath.refreshToken,
      type: RequestType.post,
      headers: {
        HttpHeaders.acceptLanguageHeader: language(),
      },
      responseEntityModel: const LoginResponse(),
      data: RefreshTokenRequest(refreshToken: refreshToken),
    );
    if (response.data.isNull) return null;
    await authRepository.setUserCredentials(
      userCredentials: response.data!,
    );

    return response.data!.accessToken;
  }
}
