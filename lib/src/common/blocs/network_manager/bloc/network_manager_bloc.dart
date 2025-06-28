import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/domain/network_manager/network_manager_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'network_manager_event.dart';
part 'network_manager_state.dart';

@lazySingleton
class NetworkManagerBloc extends Bloc<NetworkManagerEvent, NetworkManagerState> {
  NetworkManagerBloc(this._networkManagerRepository) : super(const NetworkManagerState()) {
    on<NetworkManagerInitialEvent>(_networkManagerInitialEvent);
  }

  final INetworkManagerRepository _networkManagerRepository;

  Future<void> _networkManagerInitialEvent(NetworkManagerInitialEvent event, Emitter<NetworkManagerState> emit) {
    return emit.forEach(
      _networkManagerRepository.status,
      onData: (streamState) => streamState,
    );
  }
}
