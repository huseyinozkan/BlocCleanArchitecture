import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'admin_operations_state.dart';

@injectable
final class AdminOperationsCubit extends Cubit<AdminOperationsState> {
  AdminOperationsCubit() : super(const AdminOperationsState());
}
