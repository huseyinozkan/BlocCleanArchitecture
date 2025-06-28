part of 'popup_manager.dart';

final class _MyDialogs {
  _MyDialogs(this._popupManager);

  final PopupManager _popupManager;
  final _errorMessageDialogId = UniqueKey().toString();

  Future<void> showErrorDialog({required BuildContext context, required String message}) {
    if (_popupManager.isPopupOpen(id: _errorMessageDialogId)) return SynchronousFuture(null);
    return _popupManager.showAdaptiveInfoDialog(
      context: context,
      id: _errorMessageDialogId,
      title: CoreText.titleMedium(
        LocalizationKey.errorMessageDialogTitle.tr(context, listen: false),
        fontWeight: FontWeight.bold,
      ),
      content: CoreText.bodyMedium(message),
    );
  }

  Future<void> showForceUpdateDialog({required BuildContext context, bool? isForceUpdate}) {
    return _popupManager.showUpdateAvailableDialog(
      context: context,
      isForceUpdate: isForceUpdate ?? true,
      title: LocalizationKey.forceUpdateDialogTitle.tr(context, listen: false),
      message: LocalizationKey.forceUpdateDialogMessage.tr(context, listen: false),
      androidPackageName: AppConstants.applicationConfiguration.androidPackageName,
    );
  }

  void showLoader({
    BuildContext? context,
    String? id,
    bool barrierDismissible = false,
    WidgetBuilder? widgetBuilder,
  }) =>
      _popupManager.showLoader(
        context: context,
        id: id,
        barrierDismissible: barrierDismissible,
        widgetBuilder: widgetBuilder,
      );

  void hidePopup<T>({String? id, T? result}) => _popupManager.hidePopup<T>(id: id, result: result);

  Future<void> showDeletionConfirmationDialog(BuildContext context, {required VoidCallback onDelete}) {
    final id = UniqueKey().toString();

    return _popupManager.showDefaultAdaptiveAlertDialog<void>(
      id: id,
      context: context,
      title: CoreText(LocalizationKey.deletionConfirmation.tr(context, listen: false)),
      content: CoreText(LocalizationKey.deletionConfirmationContent.tr(context, listen: false)),
      okButtonLabel: LocalizationKey.delete.tr(context, listen: false),
      cancelButtonLabel: LocalizationKey.giveUp.tr(context, listen: false),
      reversedActions: true,
      isDestuctiveOkButtonIOS: true,
      onOkButtonPressed: () {
        _popupManager.hidePopup<void>(id: id);
        onDelete();
      },
    );
  }

  Future<void> showConfirmationDialog(
    BuildContext context, {
    required VoidCallback okButtonPressed,
    Widget? title,
    Widget? content,
    String? okButtonLabel,
    String? cancelButtonLabel,
    bool reversedActions = true,
    bool isDestuctiveOkButtonIOS = true,
  }) {
    final id = UniqueKey().toString();

    return _popupManager.showDefaultAdaptiveAlertDialog<void>(
      id: id,
      context: context,
      title: title,
      content: content,
      okButtonLabel: okButtonLabel ?? LocalizationKey.ok.tr(context, listen: false),
      cancelButtonLabel: cancelButtonLabel ?? LocalizationKey.cancel.tr(context, listen: false),
      reversedActions: reversedActions,
      isDestuctiveOkButtonIOS: isDestuctiveOkButtonIOS,
      onOkButtonPressed: () {
        _popupManager.hidePopup<void>(id: id);
        okButtonPressed();
      },
    );
  }

  Future<void> showYesNoDialog(
    BuildContext context, {
    required VoidCallback yesButtonPressed,
    Widget? title,
    Widget? content,
  }) {
    final id = UniqueKey().toString();

    return _popupManager.showDefaultAdaptiveAlertDialog<void>(
      id: id,
      context: context,
      title: title,
      content: content,
      okButtonLabel: LocalizationKey.yes.tr(context, listen: false),
      cancelButtonLabel: LocalizationKey.no.tr(context, listen: false),
      reversedActions: true,
      onOkButtonPressed: () {
        _popupManager.hidePopup<void>(id: id);
        yesButtonPressed();
      },
    );
  }
}
