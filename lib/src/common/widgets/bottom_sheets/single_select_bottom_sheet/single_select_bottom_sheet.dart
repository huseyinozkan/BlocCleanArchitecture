import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/single_select_bottom_sheet/cubit/single_select_bottom_sheet_cubit.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/bottom_sheet_drag_handle.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/bottom_sheet_title_and_close_button_area.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/dotted_line.dart';
import 'package:bloc_clean_architecture/src/data/model/key_value_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class SingleSelectBottomSheet extends StatelessWidget {
  const SingleSelectBottomSheet({required this.list, required this.title, required this.id, this.selectedItem, super.key});

  final String title;
  final List<KeyValueModel> list;
  final KeyValueModel? selectedItem;
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SingleSelectBottomSheetCubit>()..initialized(list: list, selectedItem: selectedItem, id: id),
      child: DraggableScrollableSheet(
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
                BottomSheetTitleAndCloseButtonArea(title: title, id: id),
                verticalBox12,
                _ListView(scrollController: scrollController),
                verticalBox12,
              ],
            ),
          );
        },
      ),
    );
  }
}

@immutable
final class _ListView extends StatelessWidget {
  const _ListView({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final list = context.select((SingleSelectBottomSheetCubit cubit) => cubit.state.list);
    final selectedItem = context.read<SingleSelectBottomSheetCubit>().state.selectedItem;
    return Expanded(
      child: ListView.separated(
        controller: scrollController,
        padding: EdgeInsets.only(bottom: 48 + context.viewInsets.bottom),
        itemCount: list.length,
        separatorBuilder: (context, index) => const _Seperator(),
        itemBuilder: (context, index) => _ListViewItem(item: list[index], isSelected: list[index].key == selectedItem?.key),
      ),
    );
  }
}

@immutable
final class _Seperator extends StatelessWidget {
  const _Seperator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DottedLine(
        color: context.theme.colorScheme.surfaceDim,
      ),
    );
  }
}

@immutable
final class _ListViewItem extends StatelessWidget {
  const _ListViewItem({required this.item, this.isSelected = false});

  final KeyValueModel item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return CoreButton(
      onPressed: () {
        final popupManager = getIt<IMyPopupManager>();
        final bottomSheetId = context.read<SingleSelectBottomSheetCubit>().state.id;
        popupManager.base.hidePopup<KeyValueModel>(id: bottomSheetId, result: item);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Radio(
              value: isSelected,
              groupValue: true,
              onChanged: (value) {},
            ),
            CoreText.bodyLarge(item.value, fontWeight: FontWeight.bold),
          ],
        ),
      ),
    );
  }
}
