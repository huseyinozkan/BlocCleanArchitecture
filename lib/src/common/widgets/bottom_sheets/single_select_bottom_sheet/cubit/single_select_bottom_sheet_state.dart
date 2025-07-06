part of 'single_select_bottom_sheet_cubit.dart';

@immutable
final class SingleSelectBottomSheetState extends Equatable {
  const SingleSelectBottomSheetState({
    this.list = const [],
    this.selectedItem,
    this.id,
  });

  final List<KeyValueModel> list;
  final KeyValueModel? selectedItem;
  final String? id;

  @override
  List<Object?> get props => [
        list,
        selectedItem,
        id,
      ];

  SingleSelectBottomSheetState copyWith({
    List<KeyValueModel>? list,
    KeyValueModel? selectedItem,
    String? id,
  }) {
    return SingleSelectBottomSheetState(
      list: list ?? this.list,
      selectedItem: selectedItem ?? this.selectedItem,
      id: id ?? this.id,
    );
  }
}
