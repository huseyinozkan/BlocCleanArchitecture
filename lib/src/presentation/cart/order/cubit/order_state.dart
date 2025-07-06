part of 'order_cubit.dart';

@immutable
final class OrderState extends Equatable {
  const OrderState({
    this.selectedPaymentMethod,
    this.addresses = const [],
    this.selectedAddress,
  });

  final PaymentMethod? selectedPaymentMethod;
  final List<AddressDto> addresses;
  final AddressDto? selectedAddress;

  @override
  List<Object?> get props => [
        selectedPaymentMethod,
        addresses,
        selectedAddress,
      ];

  OrderState copyWith({
    PaymentMethod? selectedPaymentMethod,
    List<AddressDto>? addresses,
    AddressDto? selectedAddress,
  }) {
    return OrderState(
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }
}
