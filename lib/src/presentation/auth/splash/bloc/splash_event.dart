part of 'splash_bloc.dart';

@immutable
final class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class SplashInitializedEvent extends SplashEvent {
  const SplashInitializedEvent();
}
