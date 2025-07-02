import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/domain/cart_item/cart_item_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'bottom_navigation_bar_state.dart';

@injectable
final class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {
  BottomNavigationBarCubit(this._cartItemRepository) : super(const BottomNavigationBarState()) {
    _cartItemRepository.cartItemStream.listen((data) {
      if (data is CartItemChangedData) initialized();
    });
  }

  final ICartItemRepository _cartItemRepository;

  Future<void> initialized() async {
    final cartItems = await _cartItemRepository.findAll();
    final cartCount = cartItems.data?.length ?? 0;
    emit(state.copyWith(cartCount: cartCount));
  }
}
