import 'dart:async';

import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/adaptive_indicator.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/data_not_found_widget.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:bloc_clean_architecture/src/data/model/response/order_dto.dart';
import 'package:bloc_clean_architecture/src/presentation/past_orders/cubit/past_orders_cubit.dart';
import 'package:bloc_clean_architecture/src/presentation/past_orders/widget/order_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class PastOrdersView extends StatelessWidget {
  const PastOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PastOrdersCubit>()..initialized(),
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
    final status = context.select((PastOrdersCubit cubit) => cubit.state.status);
    final orders = context.select((PastOrdersCubit cubit) => cubit.state.orders);
    return status == PastOrdersStatus.loading
        ? const Center(child: AdaptiveIndicator())
        : orders.isEmpty
            ? DataNotFoundWidget(description: LocalizationKey.orderNotFoundToDisplay.tr(context))
            : const _BuildContent();
  }
}

@immutable
final class _BuildContent extends StatelessWidget {
  const _BuildContent();

  @override
  Widget build(BuildContext context) {
    final orders = context.select((PastOrdersCubit cubit) => cubit.state.orders);

    return Column(
      children: [
        Expanded(
          child: CoreListView.separated(
            onRefresh: () => context.read<PastOrdersCubit>().refresh(),
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
final class _ListTileItem extends StatelessWidget {
  const _ListTileItem({required this.order});

  final OrderDto order;

  @override
  Widget build(BuildContext context) {
    const borderRadius = 12.0;

    return GestureDetector(
      onTap: () => context.read<PastOrdersCubit>().onClickedOrderDetail(context, order: order),
      child: Container(
        margin: AppConstants.paddingConstants.pagePaddingHorizontal,
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
                  _CancelOrRepeatButton(order: order),
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

@immutable
final class _CancelOrRepeatButton extends StatelessWidget {
  const _CancelOrRepeatButton({required this.order});

  final OrderDto order;

  @override
  Widget build(BuildContext context) {
    return switch (order.status) {
      OrderStatus.pending => _CancelButton(order: order),
      OrderStatus.preparing => _CancelButton(order: order),
      _ => emptyBox,
    };
  }
}

@immutable
final class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.order});
  final OrderDto order;

  @override
  Widget build(BuildContext context) {
    return CoreFilledButton(
      borderRadius: BorderRadius.circular(24),
      backgroundColor: context.colorScheme.secondary.withValues(alpha: 0.7),
      minSize: 30,
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
            if (context.mounted) unawaited(context.read<PastOrdersCubit>().onClickedCancelButton(order: order));
          },
        );
      },
    );
  }
}
