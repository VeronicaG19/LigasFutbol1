part of 'player_experience_cubit.dart';

class PlayerExperienceState extends Equatable {
  final SimpleTextValidator title;
  final SimpleTextValidator description;
  final String? league;
  final String? category;
  final String? tournament;
  final String? team;
  final FormzStatus status;
  final String? errorMessage;

  const PlayerExperienceState({
    this.title = const SimpleTextValidator.pure(),
    this.description = const SimpleTextValidator.pure(),
    this.league,
    this.category,
    this.tournament,
    this.team,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  PlayerExperienceState copyWith({
    SimpleTextValidator? title,
    SimpleTextValidator? description,
    String? league,
    String? category,
    String? tournament,
    String? team,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return PlayerExperienceState(
      title: title ?? this.title,
      description: description ?? this.description,
      league: league ?? this.league,
      category: category ?? this.category,
      tournament: tournament ?? this.tournament,
      team: team ?? this.team,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [title, description, league, category, tournament, team, status];
}
