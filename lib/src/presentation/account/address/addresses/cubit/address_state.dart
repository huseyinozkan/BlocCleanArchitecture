part of 'address_cubit.dart';

enum AddressStatus { initial, loaded }

@immutable
final class AddressState extends Equatable {
  const AddressState({
    this.status = AddressStatus.initial,
    this.addresses = const [],
  });

  final AddressStatus status;
  final List<AddressDto> addresses;

  @override
  List<Object?> get props => [
        status,
        addresses,
      ];

  AddressState copyWith({
    AddressStatus? status,
    List<AddressDto>? addresses,
  }) {
    return AddressState(
      status: status ?? this.status,
      addresses: addresses ?? this.addresses,
    );
  }
}
