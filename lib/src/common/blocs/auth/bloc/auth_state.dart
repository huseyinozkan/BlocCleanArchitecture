part of 'auth_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unAuthenticated }

class AuthState extends Equatable {
  const AuthState._({required this.status, required this.userCredentials});

  const AuthState.unknown() : this._(status: AuthenticationStatus.unknown, userCredentials: null);
  const AuthState.unAuthenticated() : this._(status: AuthenticationStatus.unAuthenticated, userCredentials: null);
  const AuthState.authenticated({LoginResponse? userCredentials}) : this._(status: AuthenticationStatus.authenticated, userCredentials: userCredentials);

  final AuthenticationStatus status;
  final LoginResponse? userCredentials;

  @override
  List<Object?> get props => [status, userCredentials];

  AuthState copyWith({AuthenticationStatus? status, LoginResponse? userCredentials}) {
    return AuthState._(
      status: status ?? this.status,
      userCredentials: userCredentials ?? this.userCredentials,
    );
  }
}
