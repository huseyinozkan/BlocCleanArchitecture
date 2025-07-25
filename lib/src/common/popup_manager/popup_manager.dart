import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/admin_order_detail_bottom_sheet/view/admin_order_detail_bottom_sheet.dart';
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/order_detail_bottom_sheet/view/order_detail_bottom_sheet.dart';
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/select_address_bottom_sheet.dart';
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/select_country_code_bottom_sheet_widget.dart';
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/single_select_bottom_sheet/single_select_bottom_sheet.dart';
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/web_content_bottom_sheet_widget.dart';
import 'package:bloc_clean_architecture/src/data/model/country.dart';
import 'package:bloc_clean_architecture/src/data/model/key_value_model.dart';
import 'package:bloc_clean_architecture/src/data/model/response/address_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/order_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'bottom_sheets.dart';
part 'dialogs.dart';

abstract interface class IMyPopupManager {
  PopupManager get base;
  _MyDialogs get dialogs;
  _BottomSheets get bottomSheets;
}

@LazySingleton(as: IMyPopupManager)
final class MyPopupManager implements IMyPopupManager {
  MyPopupManager(this._routerService);
  final IMyRouterService _routerService;

  late final _popupManager = PopupManager(navigatorKey: _routerService.rootNavigatorKey);

  @override
  PopupManager get base => _popupManager;

  @override
  late final dialogs = _MyDialogs(base);

  @override
  late final bottomSheets = _BottomSheets(base);
}
