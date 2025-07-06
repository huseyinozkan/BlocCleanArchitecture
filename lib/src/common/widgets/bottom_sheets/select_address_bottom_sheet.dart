import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/bottom_sheet_drag_handle.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/bottom_sheet_title_and_close_button_area.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/dotted_line.dart';
import 'package:bloc_clean_architecture/src/data/model/response/address_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class SelectAddressBottomSheet extends StatelessWidget {
  const SelectAddressBottomSheet({required this.id, required this.list, this.selectedItem, super.key});

  final String id;
  final List<AddressDto> list;
  final AddressDto? selectedItem;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.5, // Minimum yükseklik (%50)
      snap: true, // Kaydırma sonrasında belirli noktalara sabitlenme
      snapSizes: const [0.5, 1.0], // Sabitlenebilecek yükseklikler
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalBox12,
              const BottomSheetDragHandle(),
              verticalBox12,
              BottomSheetTitleAndCloseButtonArea(title: LocalizationKey.selectAddress.tr(context), id: id),
              verticalBox12,
              listView(context, scrollController),
              verticalBox12,
            ],
          ),
        );
      },
    );
  }

  Widget listView(BuildContext context, ScrollController scrollController) {
    return Expanded(
      child: ListView.separated(
        controller: scrollController,
        padding: EdgeInsets.only(bottom: 48 + context.viewInsets.bottom),
        itemCount: list.length,
        separatorBuilder: (context, index) => seperator(context),
        itemBuilder: (context, index) => listViewItem(context, item: list[index], isSelected: list[index].id == selectedItem?.id),
      ),
    );
  }

  Widget seperator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DottedLine(
        color: context.theme.colorScheme.surfaceDim,
      ),
    );
  }

  Widget listViewItem(BuildContext context, {required AddressDto item, required bool isSelected}) {
    return CoreButton(
      onPressed: () => getIt<IMyPopupManager>().base.hidePopup<AddressDto>(id: id, result: item),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Radio(
              value: isSelected,
              groupValue: true,
              onChanged: (value) {},
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CoreText.bodyLarge(item.name, fontWeight: FontWeight.bold),
                  CoreText.labelMedium(item.addressDescription),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
