import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/domain/sqflite_manager/sqflite_manager_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'sqflite_manager_event.dart';
part 'sqflite_manager_state.dart';

@lazySingleton
class SqfliteManagerBloc extends Bloc<SqfliteManagerEvent, SqfliteManagerState> {
  SqfliteManagerBloc(this._sqfliteManagerRepository) : super(const SqfliteManagerState()) {
    on<SqfliteManagerInitialEvent>(_sqfliteManagerInitialEvent);
  }

  final ISqfliteManagerRepository _sqfliteManagerRepository;

  Future<void> _sqfliteManagerInitialEvent(SqfliteManagerInitialEvent event, Emitter<SqfliteManagerState> emit) {
    return emit.forEach(
      _sqfliteManagerRepository.status,
      onData: (streamState) => streamState,
    );
  }
}
