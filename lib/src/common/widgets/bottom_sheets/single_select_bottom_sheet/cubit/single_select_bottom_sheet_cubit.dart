import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/data/model/key_value_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'single_select_bottom_sheet_state.dart';

@injectable
final class SingleSelectBottomSheetCubit extends Cubit<SingleSelectBottomSheetState> {
  SingleSelectBottomSheetCubit() : super(const SingleSelectBottomSheetState());

  void initialized({List<KeyValueModel>? list, KeyValueModel? selectedItem, String? id}) {
    emit(state.copyWith(list: list, selectedItem: selectedItem, id: id));
  }
}
