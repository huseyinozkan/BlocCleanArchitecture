import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/domain/indicator/indicator_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'indicator_event.dart';
part 'indicator_state.dart';

@lazySingleton
class IndicatorBloc extends Bloc<IndicatorEvent, IndicatorState> {
  IndicatorBloc(this._indicatorRepository) : super(const IndicatorInitial()) {
    on<IndicatorInitializedEvent>(_initializedIndicator);
  }

  final IIndicatorRepository _indicatorRepository;

  Future<void> _initializedIndicator(IndicatorInitializedEvent event, Emitter<IndicatorState> emit) {
    return emit.forEach(_indicatorRepository.status, onData: (indicatorState) => indicatorState);
  }
}
