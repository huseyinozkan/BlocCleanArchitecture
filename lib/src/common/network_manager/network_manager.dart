import 'dart:io';

import 'package:bloc_clean_architecture/src/common/blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/common/blocs/localization/bloc/localization_bloc.dart';
import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/interceptors/dio_network_unauthorized_interceptor.dart';
import 'package:bloc_clean_architecture/src/common/interceptors/refresh_token_interceptor.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

typedef ValidateStatus = bool Function(int? statusCode);

@lazySingleton
final class NetworkManager extends CoreNetworkManager {
  NetworkManager()
      : super(
          baseOptions: BaseOptions(
            baseUrl: AppConstants.networkConstants.baseUrl,
          ),
          interceptors: [
            // DioNetworkErrorLogInterceptor(),
            // DioFirebasePerformanceInterceptor(),
            DioNetworkUnauthorizedInterceptor(),
            RefreshTokenInterceptor(),
          ],
          printLogRequestInfo: true,
          printLogErrorResponseInfo: true,
          printLogResponseInfo: true,
        );

  IAuthRepository get _authRepository => getIt<IAuthRepository>();

  @override
  Future<BaseResponse<T>> request<T, M extends BaseModel<dynamic>>({
    required BaseRequestPath path,
    required RequestType type,
    required M responseEntityModel,
    bool hasBaseResponse = true,
    BaseModel<dynamic>? data,
    FormData? dioFormData,
    BaseModel<dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? pathSuffix,
    String? contentType,
    ResponseType? responseType,
    CancelToken? cancelToken,
    ValidateStatus? validateStatus,
    Duration connectionTimeout = const Duration(seconds: 25),
    Duration receiveTimeout = const Duration(seconds: 25),
    Duration sendTimeout = const Duration(seconds: 25),
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
  }) async {
    return await super.request<T, M>(
      path: path,
      type: type,
      responseEntityModel: responseEntityModel,
      hasBaseResponse: hasBaseResponse,
      data: data,
      dioFormData: dioFormData,
      queryParameters: queryParameters,
      headers: headers,
      pathSuffix: pathSuffix,
      contentType: contentType,
      responseType: responseType,
      cancelToken: cancelToken,
      validateStatus: validateStatus,
      connectionTimeout: connectionTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    ) as BaseResponse<T>;
  }

  @override
  Future<BaseResponse<T>> primitiveRequest<T>({
    required BaseRequestPath path,
    required RequestType type,
    BaseModel<dynamic>? data,
    FormData? dioFormData,
    BaseModel<dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? pathSuffix,
    String? contentType,
    ResponseType? responseType,
    CancelToken? cancelToken,
    ValidateStatus? validateStatus,
    Duration connectionTimeout = const Duration(seconds: 25),
    Duration receiveTimeout = const Duration(seconds: 25),
    Duration sendTimeout = const Duration(seconds: 25),
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
  }) async {
    return await super.primitiveRequest<T>(
      path: path,
      type: type,
      data: data,
      dioFormData: dioFormData,
      queryParameters: queryParameters,
      headers: headers,
      pathSuffix: pathSuffix,
      contentType: contentType,
      responseType: responseType,
      cancelToken: cancelToken,
      validateStatus: validateStatus,
      connectionTimeout: connectionTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    ) as BaseResponse<T>;
  }

  @override
  Map<String, dynamic> generateHeaders({required BaseRequestPath path}) {
    String? language() => getIt<IMyRouterService>().rootNavigatorKey.currentContext?.read<LocalizationBloc>().state.localization?.culture?.name ?? 'en-US';
    String? token() => _authRepository.getUserCredentials()?.accessToken;

    Map<String, dynamic> baseHeader() => {
          HttpHeaders.acceptLanguageHeader: language(),
        };

    return switch (path) {
      RequestPath.login || RequestPath.refreshToken || RequestPath.sendOtpCode || RequestPath.register || RequestPath.forgotPassword || RequestPath.culture || RequestPath.resource => baseHeader(),
      _ => baseHeader()..addAll({'Authorization': 'Bearer ${token()}'}),
      //_ => baseHeader()..addAll({'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIrOTB8NTM0MjAyNTE2MSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE3NDUwMDg3MTAsImV4cCI6MTc0NTAxMDUxMH0.1-b250LZU0515nmfCKOsZtG4S07FaU4yyblEo2GbvQs'}),
    };
  }

  @override
  void onUnauthorized(DioException error) {
    if (error.requestOptions.path != RequestPath.login.asString) {
      _authRepository
        ..deleteUserCredentials()
        ..changeAuthState(authState: const AuthState.unAuthenticated());
    }
  }

  @override
  BaseResponse<T> getSuccessPrimitiveResponse<T>({required Response<T> response}) {
    return BaseResponse(data: response.data, success: true, statusCode: response.statusCode);
  }

  @override
  BaseResponse<T> getSuccessResponse<T, M extends BaseModel<dynamic>>({required Response<Map<String, dynamic>> response, required M responseEntityModel, required bool hasBaseResponse}) {
    late dynamic json;
    if (hasBaseResponse) {
      json = response.data?['data'];
    } else {
      json = response.data;
    }

    T? data;

    if (json is List<dynamic>) {
      data = json.map((e) => responseEntityModel.fromJson(e as Map<String, dynamic>)).toList().cast<M>() as T;
    } else if (json is Map<String, dynamic>) {
      data = responseEntityModel.fromJson(json) as T;
    } else {
      data = json as T?;
    }
    final successBoolJson = response.data?['success'];
    final succeeded = successBoolJson as bool?;
    final successMessageJson = response.data?['messages'];
    final messages = (successMessageJson as List<dynamic>?)?.map((e) => e as String).toList();
    final statusCode = response.statusCode;

    return BaseResponse<T>(data: data, success: succeeded, messages: messages, statusCode: statusCode);
  }

  @override
  BaseResponse<T> getErrorResponse<T>({required Object error}) {
    try {
      int? statusCode;
      List<String>? messages;

      if (error is DioException) {
        statusCode = error.response?.statusCode;
        if (error.response?.data is Map<String, dynamic>) {
          final data = error.response!.data as Map<String, dynamic>;
          if (data['messages'] is List<dynamic>) {
            final json = data['messages'];
            messages = (json as List<dynamic>).map((e) => e as String).toList();
          }
        }
      }

      return BaseResponse<T>(success: false, error: error, messages: messages, statusCode: statusCode);
    } catch (e) {
      return BaseResponse<T>(success: false, error: error);
    }
  }
}
