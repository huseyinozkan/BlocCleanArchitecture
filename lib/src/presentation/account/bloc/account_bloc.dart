import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/data/model/response/login_response.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'account_event.dart';
part 'account_state.dart';

@injectable
final class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(this._authRepository) : super(const AccountState()) {
    on<AccountInitializedEvet>(_initialize);
    on<AccountLogoutButtonPressedEvet>(_logout);
  }

  final IAuthRepository _authRepository;

  LoginResponse? get userCredentials => _authRepository.getUserCredentials();

  Future<void> _initialize(AccountInitializedEvet event, Emitter<AccountState> emit) async {
    final version = await CorePackageInfo.instance.version;
    emit(state.copyWith(version: version));
  }

  Future<void> _logout(AccountLogoutButtonPressedEvet event, Emitter<AccountState> emit) async {
    await _authRepository.deleteUserCredentials();
    _authRepository.changeAuthState(authState: const AuthState.unAuthenticated());
  }
}
