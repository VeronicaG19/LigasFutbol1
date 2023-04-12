import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_qra.g.dart';

@JsonSerializable()
class QraCategory extends Equatable {
  final int? categoryId;
  final String? categoryName;
  final String? icon;
  final int? appId;

  const QraCategory({
    this.categoryId,
    this.categoryName,
    this.icon,
    this.appId,
  });
  static const empty = QraCategory(categoryName: '');

  /// Connect the generated [_$QraCategoryFromJson] function to the `fromJson`
  /// factory.
  factory QraCategory.fromJson(Map<String, dynamic> json) =>
      _$QraCategoryFromJson(json);

  /// Connect the generated [_$QraCategoryToJson] function to the `toJson` method.
  // Map<String, dynamic> toJson() => _$CategoryToJson(this);
  QraCategory copyWith({
    int? categoryId,
    String? categoryName,
    String? icon,
    int? appId,
  }) {
    return QraCategory(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      icon: icon ?? this.icon,
      appId: appId ?? this.appId,
    );
  }

  @override
  List<Object?> get props => [categoryId, categoryName, icon, appId];
}
