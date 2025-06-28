part of 'sqflite_manager_bloc.dart';

@immutable
final class SqfliteManagerState extends Equatable {
  const SqfliteManagerState({
    this.baseResult,
  });

  final BaseResult<dynamic>? baseResult;

  @override
  List<Object?> get props => [baseResult];
}

@immutable
final class SqfliteManagerSuccess extends SqfliteManagerState {
  const SqfliteManagerSuccess({required super.baseResult});
}

@immutable
final class SqfliteManagerError extends SqfliteManagerState {
  const SqfliteManagerError({required super.baseResult});
}
