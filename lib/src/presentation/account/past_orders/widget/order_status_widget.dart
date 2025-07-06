import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/order_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({super.key, this.orderStatus});

  final OrderStatus? orderStatus;

  @override
  Widget build(BuildContext context) {
    return switch (orderStatus) {
      OrderStatus.pending => const _Pending(),
      OrderStatus.preparing => const _Preparing(),
      OrderStatus.delivered => const _Delivered(),
      OrderStatus.cancelled => const _Cancelled(),
      _ => emptyBox,
    };
  }
}

@immutable
final class _Delivered extends StatelessWidget {
  const _Delivered();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Icon(Icons.check_circle, color: context.colorScheme.primary, size: 18),
        CoreText.labelMedium(LocalizationKey.delivered.tr(context), textColor: context.colorScheme.primary),
      ],
    );
  }
}

@immutable
final class _Pending extends StatelessWidget {
  const _Pending();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Icon(Icons.watch_later, color: context.colorScheme.primary, size: 18),
        CoreText.labelMedium(LocalizationKey.pending.tr(context), textColor: context.colorScheme.primary),
      ],
    );
  }
}

@immutable
final class _Preparing extends StatelessWidget {
  const _Preparing();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Icon(Icons.watch_later, color: context.colorScheme.primary, size: 18),
        CoreText.labelMedium(LocalizationKey.preparing.tr(context), textColor: context.colorScheme.primary),
      ],
    );
  }
}

@immutable
final class _Cancelled extends StatelessWidget {
  const _Cancelled();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Icon(Icons.cancel_outlined, color: context.colorScheme.onSurface.withValues(alpha: 0.5), size: 18),
        CoreText.labelMedium(LocalizationKey.cancelled.tr(context), textColor: context.colorScheme.onSurface.withValues(alpha: 0.5)),
      ],
    );
  }
}
