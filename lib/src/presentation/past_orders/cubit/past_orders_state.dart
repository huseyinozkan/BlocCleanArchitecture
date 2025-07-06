part of 'past_orders_cubit.dart';

enum PastOrdersStatus { loading, loaded }

@immutable
final class PastOrdersState extends Equatable {
  const PastOrdersState({
    this.status = PastOrdersStatus.loading,
    this.orders = const [],
  });

  final PastOrdersStatus status;
  final List<OrderDto> orders;

  @override
  List<Object> get props => [
        status,
        orders,
      ];

  PastOrdersState copyWith({
    PastOrdersStatus? status,
    List<OrderDto>? orders,
  }) {
    return PastOrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
    );
  }
}
