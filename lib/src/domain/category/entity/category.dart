import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/entity/league.dart';

part 'category.g.dart';

///
/// Class of a categories on a tournament
///
@JsonSerializable()
class Category extends Equatable {
  final int? categoryId;
  final String categoryName;
  final int? ageMin;
  final int? ageMax;
  final int? gender;
  final int? yellowForPunishment;
  final int? redForPunishment;
  final String? categoryComment;
  final String? sportType;
  final int? hierarchyLevel;
  final League? leagueId;

  const Category({
    this.categoryId,
    required this.categoryName,
    this.ageMin,
    this.ageMax,
    this.gender,
    this.yellowForPunishment,
    this.redForPunishment,
    this.categoryComment,
    this.sportType,
    this.hierarchyLevel,
    this.leagueId,
  });

  static const empty = Category(categoryName: '');

  /// Connect the generated [_$CategoryFromJson] function to the `fromJson`
  /// factory.
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  /// Connect the generated [_$CategoryToJson] function to the `toJson` method.
  // Map<String, dynamic> toJson() => _$CategoryToJson(this);

  Category copyWith({
    int? categoryId,
    String? categoryName,
    int? ageMin,
    int? ageMax,
    int? gender,
    int? yellowForPunishment,
    int? redForPunishment,
    String? categoryComment,
    String? sportType,
    int? hierarchyLevel,
    League? leagueId,
  }) {
    return Category(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      ageMin: ageMin ?? this.ageMin,
      ageMax: ageMax ?? this.ageMax,
      gender: gender ?? this.gender,
      yellowForPunishment: yellowForPunishment ?? this.yellowForPunishment,
      redForPunishment: redForPunishment ?? this.redForPunishment,
      categoryComment: categoryComment ?? this.categoryComment,
      sportType: sportType ?? this.sportType,
      hierarchyLevel: hierarchyLevel ?? this.hierarchyLevel,
      leagueId: leagueId ?? this.leagueId,
    );
  }

  @override
  List<Object?> get props => [
        categoryId,
        categoryName,
        ageMin,
        ageMax,
        gender,
        yellowForPunishment,
        redForPunishment,
        categoryComment,
        sportType,
        hierarchyLevel,
        leagueId,
      ];
  Map<String, dynamic> toJson() => <String, dynamic>{
        'categoryId': categoryId,
        'categoryName': categoryName,
        'ageMin': ageMin,
        'ageMax': ageMax,
        'gender': gender,
        'yellowForPunishment': yellowForPunishment,
        'redForPunishment': redForPunishment,
        'categoryComment': categoryComment,
        'sportType': sportType,
        'hierarchyLevel': hierarchyLevel,
        'leagueId': leagueId?.toJson(),
      };
}
