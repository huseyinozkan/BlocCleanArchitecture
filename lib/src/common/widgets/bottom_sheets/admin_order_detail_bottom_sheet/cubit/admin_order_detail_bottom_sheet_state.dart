part of 'admin_order_detail_bottom_sheet_cubit.dart';

@immutable
final class AdminOrderDetailBottomSheetState extends Equatable {
  const AdminOrderDetailBottomSheetState({
    this.selectedOrderStatus,
  });

  final OrderStatus? selectedOrderStatus;

  @override
  List<Object?> get props => [selectedOrderStatus];

  AdminOrderDetailBottomSheetState copyWith({
    OrderStatus? selectedOrderStatus,
  }) {
    return AdminOrderDetailBottomSheetState(
      selectedOrderStatus: selectedOrderStatus ?? this.selectedOrderStatus,
    );
  }
}
