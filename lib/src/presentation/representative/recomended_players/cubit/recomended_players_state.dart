part of 'recomended_players_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  nullData,
  error,
}

class RecomendedPlayersState extends Equatable {
  final List<RecomendationDto> recomendationsList;
  final String? errorMessage;
  final ScreenStatus screenStatus;
  final FormzStatus status;

  const RecomendedPlayersState({
    this.recomendationsList = const [],
    this.screenStatus = ScreenStatus.initial,
    this.errorMessage,
    this.status = FormzStatus.pure,
  });

  RecomendedPlayersState copyWith(
      {List<RecomendationDto>? recomendationsList,
      ScreenStatus? screenStatus,
      String? errorMessage,
      FormzStatus? status}) {
    return RecomendedPlayersState(
        recomendationsList: recomendationsList ?? this.recomendationsList,
        screenStatus: screenStatus ?? this.screenStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props =>
      [recomendationsList, screenStatus, errorMessage, status];
}
