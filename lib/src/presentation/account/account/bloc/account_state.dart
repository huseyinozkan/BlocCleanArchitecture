part of 'account_bloc.dart';

@immutable
final class AccountState extends Equatable {
  const AccountState({this.version});

  final String? version;

  @override
  List<Object?> get props => [version];

  AccountState copyWith({String? version}) {
    return AccountState(
      version: version ?? this.version,
    );
  }
}
