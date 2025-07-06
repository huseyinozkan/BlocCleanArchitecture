import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class BottomSheetDragHandle extends StatelessWidget {
  const BottomSheetDragHandle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 4,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceDim,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
