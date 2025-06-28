part of 'network_manager_bloc.dart';

@immutable
final class NetworkManagerState {
  const NetworkManagerState({
    this.baseResponse,
  });

  final BaseResponse<dynamic>? baseResponse;
}

@immutable
final class NetworkManagerSuccess extends NetworkManagerState {
  const NetworkManagerSuccess({required super.baseResponse});
}

@immutable
final class NetworkManagerError extends NetworkManagerState {
  const NetworkManagerError({required super.baseResponse});
}
