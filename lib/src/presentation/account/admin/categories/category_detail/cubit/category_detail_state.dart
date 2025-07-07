part of 'category_detail_cubit.dart';

enum CategoryDetailStatus {
  initial,
  loaded,
}

@immutable
final class CategoryDetailState extends Equatable {
  const CategoryDetailState({
    this.status = CategoryDetailStatus.initial,
    this.category,
  });

  final CategoryDetailStatus status;
  final CategoryDto? category;

  @override
  List<Object?> get props => [
        status,
        category,
      ];

  CategoryDetailState copyWith({
    CategoryDetailStatus? status,
    CategoryDto? category,
  }) {
    return CategoryDetailState(
      status: status ?? this.status,
      category: category ?? this.category,
    );
  }
}
