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

  Future<AddressDto?> showSelectAddressBottomSheet({required BuildContext context, required List<AddressDto> list, AddressDto? selectedItem}) {
    final id = UniqueKey().toString();
    return _popupManager.showModalBottomSheet<AddressDto>(
      id: id,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectAddressBottomSheet(list: list, selectedItem: selectedItem, id: id),
    );
  }

  Future<KeyValueModel?> showSingleSelectBottomSheet({required BuildContext context, required String title, required List<KeyValueModel> list, KeyValueModel? selectedItem}) {
    final id = UniqueKey().toString();
    return _popupManager.showModalBottomSheet<KeyValueModel>(
      id: id,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SingleSelectBottomSheet(title: title, list: list, selectedItem: selectedItem, id: id),
    );
  }

  Future<bool?> showOrderDetailBottomSheet({required BuildContext context, required OrderDto order}) {
    final id = UniqueKey().toString();

    return _popupManager.showModalBottomSheet<bool>(
      id: id,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OrderDetailBottomSheet(
        arguments: OrderDetailBottomSheetArguments(order: order, bottomSheetId: id),
      ),
    );
  }

  Future<bool?> showAdminOrderDetailBottomSheet({required BuildContext context, required OrderDto order}) {
    final id = UniqueKey().toString();

    return _popupManager.showModalBottomSheet<bool>(
      id: id,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AdminOrderDetailBottomSheet(
        arguments: AdminOrderDetailBottomSheetArguments(order: order, bottomSheetId: id),
      ),
    );
  }
}
