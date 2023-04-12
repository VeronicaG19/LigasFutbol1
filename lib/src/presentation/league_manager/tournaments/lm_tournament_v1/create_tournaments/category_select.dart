import 'package:equatable/equatable.dart';

import '../../../../../domain/category/category.dart';

class CategorySelect extends Equatable {
  final bool? isSelect;
  final Category? category;

  CategorySelect({this.isSelect, this.category});

  CategorySelect copyWith({
    bool? isSelect,
    Category? category,
  }) {
    return CategorySelect(
      isSelect: isSelect ?? this.isSelect,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [isSelect, category];
}
