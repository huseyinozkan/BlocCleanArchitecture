part of 'sqflite_manager_bloc.dart';

@immutable
final class SqfliteManagerEvent extends Equatable {
  const SqfliteManagerEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class SqfliteManagerInitialEvent extends SqfliteManagerEvent {
  const SqfliteManagerInitialEvent();
}
