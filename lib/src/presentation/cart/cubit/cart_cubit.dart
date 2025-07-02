import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/data/model/request/insert_cart_item_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/cart_item_dto.dart';
import 'package:bloc_clean_architecture/src/domain/cart_item/cart_item_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'cart_state.dart';

@injectable
final class CartCubit extends Cubit<CartState> {
  CartCubit(this._cartItemRepository) : super(const CartState()) {
    _cartItemRepository.cartItemStream.listen((data) {
      if (data is CartItemChangedData) cartItemChanged();
    });
  }

  final ICartItemRepository _cartItemRepository;

  Future<void> initialized() async {
    final cartItemsResponse = await _cartItemRepository.findAll().intercept(showSuccessMessage: false);
    emit(state.copyWith(cartItems: cartItemsResponse.data));
  }

  Future<void> cartItemChanged() async {
    final cartItemsResponse = await _cartItemRepository.findAll().intercept(showSuccessMessage: false);
    emit(state.copyWith(cartItems: cartItemsResponse.data));
  }

  Future<void> increaseProductQuantity(CartItemDto cartItem) async {
    final request = InsertCartItemRequest(productId: cartItem.product?.id);
    await _cartItemRepository.save(request).intercept(showSuccessMessage: false);
    _cartItemRepository.cartItemChanged();
  }

  Future<void> decreaseProductQuantity(CartItemDto cartItem) async {
    await _cartItemRepository.deleteById(cartItem.id!).intercept(showSuccessMessage: false);
    _cartItemRepository.cartItemChanged();
  }

  Future<void> deleteProduct(CartItemDto cartItem) async {
    final ids = state.cartItems.where((e) => e.product?.id == cartItem.product?.id).map((e) => e.id).toList();
    await Future.wait([
      ...ids.map((id) => _cartItemRepository.deleteById(id!).intercept(showSuccessMessage: false)),
    ]);
    _cartItemRepository.cartItemChanged();
  }

  Future<void> deleteAllProducts() async {
    await _cartItemRepository.deleteAll().intercept(showSuccessMessage: false).withIndicator();
    _cartItemRepository.cartItemChanged();
  }
}
