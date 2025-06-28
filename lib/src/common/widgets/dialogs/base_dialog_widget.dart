import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class BaseDialogWidget extends StatelessWidget {
  const BaseDialogWidget({required this.child, required this.id, super.key});

  final String id;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final popupManager = getIt<IMyPopupManager>();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: context.height * 0.7),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
          verticalBox8,
          CoreIconButton(
            onPressed: () => popupManager.dialogs.hidePopup<void>(id: id),
            icon: CircleAvatar(
              radius: context.width * 0.07,
              backgroundColor: context.colorScheme.surface,
              child: Icon(Icons.close, color: context.colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
