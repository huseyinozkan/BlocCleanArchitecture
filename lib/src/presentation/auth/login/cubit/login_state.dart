part of 'login_cubit.dart';

@immutable
final class LoginState extends Equatable {
  const LoginState({
    this.userAgreementValue = false,
    this.privacyAgreementValue = false,
  });

  final bool userAgreementValue;
  final bool privacyAgreementValue;

  @override
  List<Object> get props => [
        userAgreementValue,
        privacyAgreementValue,
      ];

  LoginState copyWith({
    bool? userAgreementValue,
    bool? privacyAgreementValue,
  }) {
    return LoginState(
      userAgreementValue: userAgreementValue ?? this.userAgreementValue,
      privacyAgreementValue: privacyAgreementValue ?? this.privacyAgreementValue,
    );
  }
}
