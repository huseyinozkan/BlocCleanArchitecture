import 'package:flutter_core/flutter_core.dart';

final class BaseResponse<T> extends CoreBaseResponse {
  const BaseResponse({
    this.data,
    this.success,
    this.messages,
    this.statusCode,
    this.error,
  });

  final T? data;
  final bool? success;
  final List<String>? messages;
  final int? statusCode;
  final Object? error;

  bool get isFailure => !(success ?? false);
  bool get isSuccess => success ?? false;
}
