part of 'cart_cubit.dart';

@immutable
final class CartState extends Equatable {
  const CartState({
    this.cartItems = const [],
  });

  final List<CartItemDto> cartItems;

  @override
  List<Object> get props => [
        cartItems,
      ];

  CartState copyWith({
    List<CartItemDto>? cartItems,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
    );
  }
}
