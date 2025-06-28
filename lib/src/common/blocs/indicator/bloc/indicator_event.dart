part of 'indicator_bloc.dart';

sealed class IndicatorEvent extends Equatable {
  const IndicatorEvent();

  @override
  List<Object> get props => [];
}

final class IndicatorInitializedEvent extends IndicatorEvent {
  const IndicatorInitializedEvent();

  @override
  List<Object> get props => [];
}
