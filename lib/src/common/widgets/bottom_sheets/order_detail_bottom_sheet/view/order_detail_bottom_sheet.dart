import 'dart:async';

import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/order_detail_bottom_sheet/cubit/order_detail_bottom_sheet_cubit.dart';
import 'package:bloc_clean_architecture/src/common/widgets/network_image/cached_network_image.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/bottom_sheet_drag_handle.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/bottom_sheet_title_and_close_button_area.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/dotted_line.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:bloc_clean_architecture/src/data/model/response/cart_item_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/order_dto.dart';
import 'package:bloc_clean_architecture/src/presentation/past_orders/widget/order_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

class OrderDetailBottomSheetArguments {
  OrderDetailBottomSheetArguments({
    required this.order,
    required this.bottomSheetId,
  });

  final OrderDto order;
  final String bottomSheetId;
}

@immutable
final class OrderDetailBottomSheet extends StatelessWidget {
  const OrderDetailBottomSheet({required this.arguments, super.key});

  final OrderDetailBottomSheetArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrderDetailBottomSheetCubit>()..argument = arguments,
      child: Builder(
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                verticalBox12,
                const BottomSheetDragHandle(),
                BottomSheetTitleAndCloseButtonArea(title: LocalizationKey.orderDetails.tr(context), id: arguments.bottomSheetId),
                const _Content(),
              ],
            ),
          );
        },
      ),
    );
  }
}

@immutable
final class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final order = context.read<OrderDetailBottomSheetCubit>().argument.order;
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: AppConstants.paddingConstants.pagePaddingHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _TitleDescriptionRow(
                      title: LocalizationKey.orderNumber.tr(context),
                      description: order.id.toString(),
                    ),
                  ),
                  OrderStatusWidget(orderStatus: order.status),
                ],
              ),
              _TitleDescriptionRow(
                title: LocalizationKey.orderDate.tr(context),
                description: '${order.createdDate?.todMMMMEEEE(locale: trLocale.toString())} ${order.createdDate?.toHHmm}',
              ),
              _TitleDescriptionRow(
                title: LocalizationKey.paymentMethod.tr(context),
                description: order.payment?.paymentMethod?.localizationKey.tr(context, listen: false) ?? '',
              ),
              _TitleDescriptionRow(
                title: LocalizationKey.address.tr(context),
                description: '${order.address?.name}\n${order.address?.addressDescription}\n${order.address?.district} / ${order.address?.city}',
              ),
              _TitleDescriptionRow(
                title: LocalizationKey.orderNote.tr(context),
                description: '${order.orderNote}',
              ),
              const DottedLine(),
              const _OrderItems(),
              const DottedLine(),
              _TitleDescriptionRow2(
                title: LocalizationKey.totalAmount.tr(context),
                description: '${Core.doubleToCurrency(order.totalAmount ?? 0)} ₺',
              ),
              const _CancelOrRepeatButton(),
              verticalBox64,
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
final class _OrderItems extends StatelessWidget {
  const _OrderItems();

  @override
  Widget build(BuildContext context) {
    final cartItems = context.read<OrderDetailBottomSheetCubit>().argument.order.cartItems;
    return Column(
      children: cartItems?.map((cartItem) => _CartItem(cartItem: cartItem)).toList() ?? [],
    );
  }
}

@immutable
final class _CartItem extends StatelessWidget {
  const _CartItem({required this.cartItem});

  final CartItemDto cartItem;

  @override
  Widget build(BuildContext context) {
    final totalPrice = '${Core.doubleToCurrency(cartItem.product?.price ?? 0)} ₺';
    final imageFile = cartItem.product?.imageFile;
    final productName = '${cartItem.product?.name}';

    return Row(
      spacing: 12,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: MyCachedNetworkImage(
              imageId: imageFile?.id,
              height: 50,
              width: 50,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalBox8,
              CoreText.labelMedium(productName, fontWeight: FontWeight.bold),
              verticalBox8,
            ],
          ),
        ),
        CoreText.labelMedium(
          totalPrice,
          fontWeight: FontWeight.bold,
          textColor: context.colorScheme.onSurface.withValues(alpha: 0.8),
        ),
      ],
    );
  }
}

@immutable
final class _TitleDescriptionRow extends StatelessWidget {
  const _TitleDescriptionRow({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        CoreText.labelMedium(title, fontWeight: FontWeight.bold),
        CoreText.labelMedium(
          description,
          textColor: context.colorScheme.onSurface.withValues(alpha: 0.8),
        ),
      ],
    );
  }
}

@immutable
final class _TitleDescriptionRow2 extends StatelessWidget {
  const _TitleDescriptionRow2({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Expanded(child: CoreText.labelMedium(title, fontWeight: FontWeight.bold)),
        CoreText.labelMedium(
          description,
          textColor: context.colorScheme.onSurface.withValues(alpha: 0.8),
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}

@immutable
final class _CancelOrRepeatButton extends StatelessWidget {
  const _CancelOrRepeatButton();

  @override
  Widget build(BuildContext context) {
    final status = context.read<OrderDetailBottomSheetCubit>().argument.order.status;

    return switch (status) {
      OrderStatus.pending => const _CancelButton(),
      OrderStatus.preparing => const _CancelButton(),
      _ => emptyBox,
    };
  }
}

@immutable
final class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CoreFilledButton(
          borderRadius: BorderRadius.circular(24),
          backgroundColor: context.colorScheme.secondary.withValues(alpha: 0.7),
          child: Row(
            spacing: 4,
            children: [
              Icon(Icons.close, color: context.colorScheme.onSecondary, size: 16),
              CoreText.labelMedium(LocalizationKey.cancel.tr(context), textColor: context.colorScheme.onSecondary, fontWeight: FontWeight.bold),
            ],
          ),
          onPressed: () async {
            final popupManager = getIt<IMyPopupManager>();
            await popupManager.dialogs.showYesNoDialog(
              context,
              content: CoreText(LocalizationKey.cancelButtonConfirmation.tr(context, listen: false)),
              yesButtonPressed: () {
                if (context.mounted) unawaited(context.read<OrderDetailBottomSheetCubit>().onClickedCancelButton());
              },
            );
          },
        ),
      ],
    );
  }
}
