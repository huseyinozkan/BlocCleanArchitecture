part of 'account_bloc.dart';

@immutable
final class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class AccountInitializedEvet extends AccountEvent {
  const AccountInitializedEvet();
}

@immutable
final class AccountLogoutButtonPressedEvet extends AccountEvent {
  const AccountLogoutButtonPressedEvet();
}
