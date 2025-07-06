import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/buttons/buttons.dart';
import 'package:bloc_clean_architecture/src/common/widgets/buttons/quantity_button.dart';
import 'package:bloc_clean_architecture/src/common/widgets/network_image/cached_network_image.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/data_not_found_widget.dart';
import 'package:bloc_clean_architecture/src/data/model/response/cart_item_dto.dart';
import 'package:bloc_clean_architecture/src/presentation/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';

@immutable
final class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartCubit>()..initialized(),
      child: const Scaffold(
        appBar: _AppBar(),
        body: _Body(),
        bottomNavigationBar: _AmountToBePaidAndContinueButton(),
      ),
    );
  }
}

@immutable
class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final cartItems = context.select((CartCubit cubit) => cubit.state.cartItems);
    return MyAppBar(
      leading: emptyBox,
      title: Text(LocalizationKey.cart.tr(context)),
      actions: [
        Visibility(
          visible: cartItems.isNotEmpty,
          child: CoreTextButton(
            child: CoreText.labelMedium(LocalizationKey.deleteAll.tr(context)),
            onPressed: () async {
              final result = await getIt<IMyPopupManager>().dialogs.showDeletionDialog(context: context);
              if ((result ?? false) && context.mounted) await context.read<CartCubit>().deleteAllProducts();
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final cartItems = context.select((CartCubit cubit) => cubit.state.cartItems);
    final grouped = groupBy(cartItems, (CartItemDto cartItem) => cartItem.product?.id);
    final newCartItems = grouped.values.map((cartItemList) => cartItemList.first).toList();
    return cartItems.isEmpty
        ? const _CartItemNotFound()
        : ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: newCartItems.length,
            separatorBuilder: (context, index) => verticalBox12,
            itemBuilder: (context, index) => _ListViewItem(cartItem: newCartItems[index]),
          );
  }
}

@immutable
final class _CartItemNotFound extends StatelessWidget {
  const _CartItemNotFound();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalBox64,
        DataNotFoundWidget(description: LocalizationKey.yourCartIsEmpty.tr(context)),
        verticalBox32,
        MyFilledButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CoreText.bodyMedium(
              LocalizationKey.goToProducts.tr(context),
              fontWeight: FontWeight.bold,
              textColor: context.colorScheme.onPrimary,
            ),
          ),
          onPressed: () => context.goNamed(RoutePaths.products.name),
        ),
      ],
    );
  }
}

@immutable
final class _ListViewItem extends StatelessWidget {
  const _ListViewItem({required this.cartItem});

  final CartItemDto cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        spacing: 4,
        children: [
          Row(
            spacing: 12,
            children: [
              MyCachedNetworkImage(
                imageId: cartItem.product?.imageFile?.id,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: CoreText.titleMedium(cartItem.product?.name, fontWeight: FontWeight.bold)),
                        CoreIconButton(
                          icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: context.colorScheme.onSurface),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Icon(Icons.close, color: context.colorScheme.onSurface, size: 16),
                            ),
                          ),
                          onPressed: () async {
                            final result = await getIt<IMyPopupManager>().dialogs.showDeletionDialog(context: context);
                            if ((result ?? false) && context.mounted) await context.read<CartCubit>().deleteProduct(cartItem);
                          },
                        ),
                      ],
                    ),
                    CoreText.labelMedium(cartItem.product?.description),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: context.colorScheme.onSurface),
                  borderRadius: BorderRadius.circular(18),
                  color: context.colorScheme.onSurface.withValues(alpha: 0.05),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Builder(
                    builder: (context) {
                      final cartItems = context.select((CartCubit cubit) => cubit.state.cartItems);
                      final totalPrice = cartItems.where((item) => item.product?.id == cartItem.product?.id).fold<double>(0, (sum, item) => sum + (item.product?.price ?? 0));
                      final totalPriceFormatted = '${Core.doubleToCurrency(totalPrice)} ₺';
                      return CoreText.labelMedium(totalPriceFormatted, fontWeight: FontWeight.bold);
                    },
                  ),
                ),
              ),
              const Spacer(),
              Builder(
                builder: (context) {
                  final cartItems = context.select((CartCubit cubit) => cubit.state.cartItems);
                  final quantity = cartItems.where((item) => item.product?.id == cartItem.product?.id).length;
                  return QuantityButton(
                    quantity: quantity,
                    onIncrease: () => context.read<CartCubit>().increaseProductQuantity(cartItem),
                    onDecrease: () => context.read<CartCubit>().decreaseProductQuantity(cartItem),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

@immutable
final class _AmountToBePaidAndContinueButton extends StatelessWidget {
  const _AmountToBePaidAndContinueButton();

  @override
  Widget build(BuildContext context) {
    final cartItems = context.select((CartCubit cubit) => cubit.state.cartItems);
    final totalPrice = cartItems.fold<double>(0, (sum, item) => sum + (item.product?.price ?? 0));
    final totalPriceFormatted = '${Core.doubleToCurrency(totalPrice)} ₺';
    return Visibility(
      visible: cartItems.isNotEmpty,
      child: ColoredBox(
        color: context.colorScheme.surfaceContainer,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalBox12,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CoreText.labelMedium(LocalizationKey.amountToBePaid.tr(context)),
                        CoreText.titleLarge(totalPriceFormatted, fontWeight: FontWeight.bold, textColor: context.colorScheme.primary),
                      ],
                    ),
                  ),
                  Expanded(
                    child: MyFilledButton(
                      child: CoreText.bodyMedium(LocalizationKey.continuee.tr(context), fontWeight: FontWeight.bold, textColor: context.colorScheme.onPrimary),
                      onPressed: () {
                        context.pushNamed(RoutePaths.order.name);
                      },
                    ),
                  ),
                ],
              ),
            ),
            verticalBox12,
          ],
        ),
      ),
    );
  }
}
