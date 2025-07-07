import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/adaptive_indicator.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/data_not_found_widget.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:bloc_clean_architecture/src/data/model/key_value_model.dart';
import 'package:bloc_clean_architecture/src/data/model/response/order_dto.dart';
import 'package:bloc_clean_architecture/src/presentation/account/admin/admin_orders/cubit/admin_orders_cubit.dart';
import 'package:bloc_clean_architecture/src/presentation/account/past_orders/widget/order_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class AdminOrdersView extends StatelessWidget {
  const AdminOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminOrdersCubit>()..initialized(context),
      child: const Scaffold(
        appBar: _AppBar(),
        body: _Body(),
      ),
    );
  }
}

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return MyAppBar(title: CoreText(LocalizationKey.orders.tr(context)));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final status = context.select((AdminOrdersCubit cubit) => cubit.state.status);
    return status == AdminOrdersStatus.loading ? const Center(child: AdaptiveIndicator()) : const _BuildContent();
  }
}

@immutable
final class _BuildContent extends StatelessWidget {
  const _BuildContent();

  @override
  Widget build(BuildContext context) {
    final orders = context.select((AdminOrdersCubit cubit) => cubit.state.orders);

    return Column(
      spacing: 16,
      children: [
        const _SelectOrderStatusTextField(),
        if (orders.isEmpty)
          Expanded(child: DataNotFoundWidget(description: LocalizationKey.orderNotFoundToDisplay.tr(context)))
        else
          Expanded(
            child: CoreListView.separated(
              padding: AppConstants.paddingConstants.pagePadding.add(const EdgeInsets.only(bottom: 54)),
              onRefresh: () => context.read<AdminOrdersCubit>().refresh(),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: orders.length,
              separatorBuilder: (context, index) => verticalBox16,
              itemBuilder: (context, index) => _ListTileItem(order: orders[index]),
            ),
          ),
      ],
    );
  }
}

@immutable
final class _SelectOrderStatusTextField extends StatelessWidget {
  const _SelectOrderStatusTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.paddingConstants.pagePaddingHorizontal,
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CoreText.titleMedium(LocalizationKey.orderStatus.tr(context), fontWeight: FontWeight.bold),
          TextFormField(
            controller: context.read<AdminOrdersCubit>().orderStatusController,
            decoration: InputDecoration(
              hintText: LocalizationKey.orderStatus.tr(context),
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
            readOnly: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTap: () async {
              final popupManager = getIt<IMyPopupManager>();
              const orderStatuses = OrderStatus.values;
              final selectedOrderStatus = context.read<AdminOrdersCubit>().state.selectedOrderStatus;
              final newSelectedOrderStatus = await popupManager.bottomSheets.showSingleSelectBottomSheet(
                context: context,
                title: LocalizationKey.orderStatus.tr(context, listen: false),
                list: orderStatuses.map((e) => KeyValueModel(key: e.name, value: e.localizationKey.tr(context, listen: false))).toList(),
                selectedItem: KeyValueModel(key: selectedOrderStatus?.name, value: selectedOrderStatus?.localizationKey.tr(context, listen: false)),
              );

              if (newSelectedOrderStatus.isNotNull && context.mounted) await context.read<AdminOrdersCubit>().onChangeOrderStatus(context, orderStatus: OrderStatus.values.firstWhere((e) => e.name == newSelectedOrderStatus?.key));
            },
          ),
        ],
      ),
    );
  }
}

@immutable
final class _ListTileItem extends StatelessWidget {
  const _ListTileItem({required this.order});

  final OrderDto order;

  @override
  Widget build(BuildContext context) {
    const borderRadius = 12.0;

    return GestureDetector(
      onTap: () => context.read<AdminOrdersCubit>().onClickedOrderDetail(context, order: order),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.colorScheme.onSurface.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Column(
            spacing: 12,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _OrderNumber(orderNumber: order.id.toString()),
                        _OrderDate(orderDate: order.createdDate),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 18,
                    children: [
                      _Price(order: order),
                      const _ForwardIcon(),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  OrderStatusWidget(orderStatus: order.status),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
final class _OrderNumber extends StatelessWidget {
  const _OrderNumber({required this.orderNumber});

  final String? orderNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        CoreText.labelMedium(LocalizationKey.orderNumber.tr(context), fontWeight: FontWeight.bold),
        CoreText.labelMedium(orderNumber),
      ],
    );
  }
}

@immutable
final class _OrderDate extends StatelessWidget {
  const _OrderDate({required this.orderDate});

  final DateTime? orderDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        CoreText.labelMedium(LocalizationKey.orderDate.tr(context), fontWeight: FontWeight.bold),
        CoreText.labelMedium('${orderDate?.todMMMMEEEE(locale: trLocale.toString())} ${orderDate?.toHHmm}'),
      ],
    );
  }
}

@immutable
final class _Price extends StatelessWidget {
  const _Price({
    required this.order,
  });

  final OrderDto order;

  @override
  Widget build(BuildContext context) {
    return CoreText.labelLarge('${Core.doubleToCurrency(order.totalAmount ?? 0)} ₺', fontWeight: FontWeight.bold);
  }
}

@immutable
final class _ForwardIcon extends StatelessWidget {
  const _ForwardIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.primary),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 12,
          color: context.colorScheme.primary,
        ),
      ),
    );
  }
}
