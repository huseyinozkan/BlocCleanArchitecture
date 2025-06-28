part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

@immutable
final class _AuthStateChanged extends AuthEvent {
  const _AuthStateChanged(this.authState);

  final AuthState authState;

  @override
  List<Object> get props => [authState];
}
