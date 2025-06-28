part of 'splash_bloc.dart';

@immutable
sealed class SplashState extends Equatable {
  const SplashState();
}

final class SplashInitial extends SplashState {
  const SplashInitial();

  @override
  List<Object> get props => [];
}

final class SplashProcessing extends SplashState {
  const SplashProcessing({
    required this.totalStep,
    required this.currentStep,
    required this.message,
  });

  final int totalStep;
  final int currentStep;
  final String message;

  @override
  List<Object> get props => [totalStep, currentStep, message];

  SplashProcessing copyWith({
    int? totalStep,
    int? currentStep,
    String? message,
  }) {
    return SplashProcessing(
      totalStep: totalStep ?? this.totalStep,
      currentStep: currentStep ?? this.currentStep,
      message: message ?? this.message,
    );
  }
}

final class SplashError extends SplashState {
  const SplashError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class SplashUpdateRequired extends SplashState {
  const SplashUpdateRequired();

  @override
  List<Object> get props => [];
}
