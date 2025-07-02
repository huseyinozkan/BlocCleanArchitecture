part of 'bottom_navigation_bar_cubit.dart';

@immutable
final class BottomNavigationBarState extends Equatable {
  const BottomNavigationBarState({
    this.cartCount = 0,
  });

  final int cartCount;

  @override
  List<Object> get props => [
        cartCount,
      ];

  BottomNavigationBarState copyWith({
    int? cartCount,
  }) {
    return BottomNavigationBarState(
      cartCount: cartCount ?? this.cartCount,
    );
  }
}
