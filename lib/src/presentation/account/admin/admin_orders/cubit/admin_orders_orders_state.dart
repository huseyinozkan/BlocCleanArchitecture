part of 'admin_orders_cubit.dart';

enum AdminOrdersStatus { loading, loaded }

@immutable
final class AdminOrdersState extends Equatable {
  const AdminOrdersState({
    this.status = AdminOrdersStatus.loading,
    this.selectedOrderStatus,
    this.orders = const [],
  });

  final AdminOrdersStatus status;
  final OrderStatus? selectedOrderStatus;
  final List<OrderDto> orders;

  @override
  List<Object?> get props => [
        status,
        selectedOrderStatus,
        orders,
      ];

  AdminOrdersState copyWith({
    AdminOrdersStatus? status,
    OrderStatus? selectedOrderStatus,
    List<OrderDto>? orders,
  }) {
    return AdminOrdersState(
      status: status ?? this.status,
      selectedOrderStatus: selectedOrderStatus ?? this.selectedOrderStatus,
      orders: orders ?? this.orders,
    );
  }
}
