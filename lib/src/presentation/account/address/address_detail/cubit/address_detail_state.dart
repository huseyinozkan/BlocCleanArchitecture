part of 'address_detail_cubit.dart';

enum AddressDetailStatus {
  initial,
  loaded,
}

@immutable
final class AddressDetailState extends Equatable {
  const AddressDetailState({
    this.status = AddressDetailStatus.initial,
    this.address,
  });

  final AddressDetailStatus status;
  final AddressDto? address;

  @override
  List<Object?> get props => [
        status,
        address,
      ];

  AddressDetailState copyWith({
    AddressDetailStatus? status,
    AddressDto? address,
  }) {
    return AddressDetailState(
      status: status ?? this.status,
      address: address ?? this.address,
    );
  }
}
