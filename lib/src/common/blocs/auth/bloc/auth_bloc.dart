import 'package:bloc_clean_architecture/src/data/model/response/login_response.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(const AuthState.unknown()) {
    on<_AuthStateChanged>(_authStateChanged);

    _authRepository.status.listen((state) {
      add(_AuthStateChanged(state));
    });
  }

  final IAuthRepository _authRepository;

  void _authStateChanged(_AuthStateChanged event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        status: event.authState.status,
        userCredentials: event.authState.userCredentials,
      ),
    );
  }
}
