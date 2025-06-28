import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_html/flutter_html.dart';

@immutable
final class WebContentBottomSheetWidget extends StatelessWidget {
  const WebContentBottomSheetWidget({required this.id, required this.htmlContent, super.key});

  final String id;
  final String htmlContent;

  IMyPopupManager get popupManager => getIt<IMyPopupManager>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: CoreIconButton(
              icon: CoreText.bodyMedium(LocalizationKey.accept.tr(context), textColor: context.colorScheme.primary),
              onPressed: () {
                popupManager.dialogs.hidePopup(id: id, result: true);
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Html(
                data: htmlContent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
