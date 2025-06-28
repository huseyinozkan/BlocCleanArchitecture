import 'dart:convert';

import 'package:flutter_core/flutter_core.dart';

// Bu interceptor da tokan bulunamadı hatası izleniyor. Bu hata durumunda 401 hatası döndürülüyor.
final class DioNetworkUnauthorizedInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    try {
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      final error = data['error'] as Map<String, dynamic>;
      final message = error['message'] as String;

      if (message == 'Token bulunamadı!') {
        response.statusCode = 401;
        final err = DioException(requestOptions: response.requestOptions, response: response);
        handler.reject(err);
        return;
      }
    } catch (_) {}

    handler.next(response);
  }
}
