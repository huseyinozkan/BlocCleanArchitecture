part of 'admin_cubit.dart';

enum AdminStatus { loading, loaded }

@immutable
final class AdminState extends Equatable {
  const AdminState({
    this.status = AdminStatus.loading,
  });

  final AdminStatus status;

  @override
  List<Object> get props => [
        status,
      ];

  AdminState copyWith({
    AdminStatus? status,
  }) {
    return AdminState(
      status: status ?? this.status,
    );
  }
}
