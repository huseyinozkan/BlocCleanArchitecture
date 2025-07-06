import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class BottomSheetTitleAndCloseButtonArea extends StatelessWidget {
  const BottomSheetTitleAndCloseButtonArea({required this.title, required this.id, super.key});

  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        horizontalBox48,
        Expanded(
          child: CoreText.titleMedium(
            title,
            textColor: context.colorScheme.primary,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 48,
          child: CoreButton(
            onPressed: () => getIt<IMyPopupManager>().base.hidePopup<void>(id: id),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Icon(Icons.close, color: context.colorScheme.onPrimary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
