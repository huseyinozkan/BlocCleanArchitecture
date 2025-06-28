import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'admin_state.dart';

@injectable
final class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(const AdminState());

  // final IAdminRepository _adminRepository;

  void inialized() {
    emit(state.copyWith(status: AdminStatus.loaded));
  }
}
