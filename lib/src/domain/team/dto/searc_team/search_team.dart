import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_team.g.dart';

@JsonSerializable()
class SearchTeam extends Equatable {
  final String categoryName;
  final int? leagueId;
  final String? nameLeague;
  final int? teamId;
  final String? teamName;
  final int? categoryId;
  final String? logo;

  const SearchTeam({
    required this.categoryName,
    this.leagueId,
    this.nameLeague,
    this.teamId,
    this.teamName,
    this.categoryId,
    this.logo,
  });

  /// Connect the generated [_$SearchTeamFromJson] function to the `fromJson`
  /// factory.
  factory SearchTeam.fromJson(Map<String, dynamic> json) =>
      _$SearchTeamFromJson(json);

  /// Connect the generated [_$TeamToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SearchTeamToJson(this);

  factory SearchTeam.fromMap(Map<String, dynamic> map) {
    return SearchTeam(
      categoryName: map['categoryName'] ?? '',
      leagueId: map['leagueId'] ?? 0,
      nameLeague: map['nameLeague'] ?? '',
      teamId: map['teamId'] ?? 0,
      teamName: map['teamName'] ?? '',
      categoryId: map['category'] ?? 0,
      logo: map['logo'] ?? '',
    );
  }

  SearchTeam copyWith({
    String? categoryName,
    int? leagueId,
    String? nameLeague,
    int? teamId,
    String? teamName,
    int? categoryId,
    String? logo,
  }) {
    return SearchTeam(
      categoryName: categoryName ?? this.categoryName,
      leagueId: leagueId ?? this.leagueId,
      nameLeague: nameLeague ?? this.nameLeague,
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      categoryId: categoryId ?? this.categoryId,
      logo: logo ?? this.logo,
    );
  }

  String get teamNameValidated => teamName ?? '';

  @override
  List<Object?> get props => [
        categoryName,
        leagueId,
        nameLeague,
        teamId,
        teamName,
        categoryId,
        logo,
      ];
}
