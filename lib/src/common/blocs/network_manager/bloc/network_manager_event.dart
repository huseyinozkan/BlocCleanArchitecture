part of 'network_manager_bloc.dart';

@immutable
final class NetworkManagerEvent extends Equatable {
  const NetworkManagerEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class NetworkManagerInitialEvent extends NetworkManagerEvent {
  const NetworkManagerInitialEvent();
}
