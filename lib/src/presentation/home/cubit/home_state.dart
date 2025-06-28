part of 'home_cubit.dart';

enum HomeStatus { loading, loaded }

@immutable
final class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.loading,
  });

  final HomeStatus status;

  @override
  List<Object> get props => [
        status,
      ];

  HomeState copyWith({
    HomeStatus? status,
  }) {
    return HomeState(
      status: status ?? this.status,
    );
  }
}
