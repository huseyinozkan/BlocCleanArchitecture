import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:injectable/injectable.dart';

abstract interface class IContactPickerHelper {
  Future<Contact?> selectContact();
}

@LazySingleton(as: IContactPickerHelper)
final class ContactPickerHelper implements IContactPickerHelper {
  final FlutterNativeContactPicker _contactPicker = FlutterNativeContactPicker();

  @override
  Future<Contact?> selectContact() {
    try {
      return _contactPicker.selectContact();
    } catch (e) {
      return Future.value();
    }
  }
}
