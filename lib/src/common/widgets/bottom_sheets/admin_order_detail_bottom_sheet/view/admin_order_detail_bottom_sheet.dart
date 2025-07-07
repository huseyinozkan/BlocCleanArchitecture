import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/admin_order_detail_bottom_sheet/cubit/admin_order_detail_bottom_sheet_cubit.dart';
import 'package:bloc_clean_architecture/src/common/widgets/network_image/cached_network_image.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/bottom_sheet_drag_handle.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/bottom_sheet_title_and_close_button_area.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/dotted_line.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:bloc_clean_architecture/src/data/model/key_value_model.dart';
import 'package:bloc_clean_architecture/src/data/model/response/cart_item_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/order_dto.dart';
import 'package:bloc_clean_architecture/src/presentation/account/past_orders/widget/order_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

class AdminOrderDetailBottomSheetArguments {
  AdminOrderDetailBottomSheetArguments({
    required this.order,
    required this.bottomSheetId,
  });

  final OrderDto order;
  final String bottomSheetId;
}

@immutable
final class AdminOrderDetailBottomSheet extends StatelessWidget {
  const AdminOrderDetailBottomSheet({required this.arguments, super.key});

  final AdminOrderDetailBottomSheetArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminOrderDetailBottomSheetCubit>()..initialized(context, arguments),
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
    final order = context.read<AdminOrderDetailBottomSheetCubit>().argument.order;
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: AppConstants.paddingConstants.pagePaddingHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              const _SelectOrderStatusTextField(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _TitleDescriptionRow(
                      title: LocalizationKey.orderNumber.tr(context),
                      description: order.id.toString(),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final selectedOrderStatus = context.select<AdminOrderDetailBottomSheetCubit, OrderStatus?>((cubit) => cubit.state.selectedOrderStatus);
                      return OrderStatusWidget(orderStatus: selectedOrderStatus);
                    },
                  ),
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
              verticalBox64,
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
final class _SelectOrderStatusTextField extends StatelessWidget {
  const _SelectOrderStatusTextField();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CoreText.titleMedium(LocalizationKey.orderStatus.tr(context), fontWeight: FontWeight.bold),
        TextFormField(
          controller: context.read<AdminOrderDetailBottomSheetCubit>().orderStatusController,
          decoration: InputDecoration(
            hintText: LocalizationKey.orderStatus.tr(context),
            suffixIcon: const Icon(Icons.arrow_drop_down),
          ),
          readOnly: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTap: () async {
            final popupManager = getIt<IMyPopupManager>();
            const orderStatuses = OrderStatus.values;
            final selectedOrderStatus = context.read<AdminOrderDetailBottomSheetCubit>().state.selectedOrderStatus;
            final newSelectedOrderStatus = await popupManager.bottomSheets.showSingleSelectBottomSheet(
              context: context,
              title: LocalizationKey.orderStatus.tr(context, listen: false),
              list: orderStatuses.map((e) => KeyValueModel(key: e.name, value: e.localizationKey.tr(context, listen: false))).toList(),
              selectedItem: KeyValueModel(key: selectedOrderStatus?.name, value: selectedOrderStatus?.localizationKey.tr(context, listen: false)),
            );

            if (newSelectedOrderStatus.isNotNull && context.mounted) await context.read<AdminOrderDetailBottomSheetCubit>().onChangeOrderStatus(context, orderStatus: OrderStatus.values.firstWhere((e) => e.name == newSelectedOrderStatus?.key));
          },
        ),
      ],
    );
  }
}

@immutable
final class _OrderItems extends StatelessWidget {
  const _OrderItems();

  @override
  Widget build(BuildContext context) {
    final cartItems = context.read<AdminOrderDetailBottomSheetCubit>().argument.order.cartItems;
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
