import 'package:bloc_clean_architecture/src/common/widgets/buttons/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class QuantityButton extends StatelessWidget {
  const QuantityButton({
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    super.key,
  });

  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    return quantity == 0 ? addButton(context) : quantitySelector(context);
  }

  Widget quantitySelector(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colorScheme.primary),
      ),
      child: Row(
        children: [
          if (quantity == 1) removeButton(context) else decreaseButton(context),
          quantityText(context),
          increaseButton(context),
        ],
      ),
    );
  }

  Widget addButton(BuildContext context) {
    return MyIconButton(
      onPressed: onIncrease,
      icon: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            Icons.add,
            color: context.colorScheme.onPrimary,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget removeButton(BuildContext context) {
    return MyIconButton(
      onPressed: onDecrease,
      icon: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          Icons.delete,
          color: context.colorScheme.primary,
          size: 22,
        ),
      ),
    );
  }

  Widget decreaseButton(BuildContext context) {
    return MyIconButton(
      onPressed: onDecrease,
      icon: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          Icons.remove,
          color: context.colorScheme.primary,
          size: 22,
        ),
      ),
    );
  }

  Widget quantityText(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CoreText.bodyLarge(
          quantity.toString(),
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget increaseButton(BuildContext context) {
    return MyIconButton(
      onPressed: onIncrease,
      icon: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          Icons.add,
          color: context.colorScheme.primary,
          size: 22,
        ),
      ),
    );
  }
}
