part of 'popup_manager.dart';

final class _BottomSheets {
  _BottomSheets(this._popupManager);

  final PopupManager _popupManager;

  Future<bool?> showWebContentBottomSheet(BuildContext context, {required String htmlContent}) {
    final id = UniqueKey().toString();
    return _popupManager.showModalBottomSheet<bool>(
      id: id,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => WebContentBottomSheetWidget(
        id: id,
        htmlContent: htmlContent,
      ),
    );
  }

  Future<Country?> showSelectCountryCodeBottomSheet(BuildContext context) {
    final id = UniqueKey().toString();
    return _popupManager.showModalBottomSheet<Country>(
      id: id,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => SelectCountryCodeBottomSheetWidget(id: id),
    );
  }
}
