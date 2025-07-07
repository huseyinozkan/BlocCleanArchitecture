part of 'categories_cubit.dart';

enum CategoriesStatus { initial, loaded }

@immutable
final class CategoriesState extends Equatable {
  const CategoriesState({
    this.status = CategoriesStatus.initial,
    this.categories = const [],
  });

  final CategoriesStatus status;
  final List<CategoryDto> categories;

  @override
  List<Object?> get props => [
        status,
        categories,
      ];

  CategoriesState copyWith({
    CategoriesStatus? status,
    List<CategoryDto>? categories,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }
}
