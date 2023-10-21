import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_match/detailMatchDTO.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/matches_by_player/matches_by_player.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/service/i_matches_service.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/domain/team/service/i_team_service.dart';

part 'matches_state.dart';

@injectable
class MatchesCubit extends Cubit<MatchesState> {
  MatchesCubit(this._matchesService, this._teamService)
      : super(const MatchesState());

  final IMatchesService _matchesService;
  final ITeamService _teamService;

  Future<void> getMatchesByPlayer(int personId, int teamId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _matchesService.getMatchesByPlayer(personId, teamId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, matchesList: r, myTeam: teamId));
    });
  }

  Future<void> getTeamByPlayer({required int personId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _teamService.getsAllTeamsPlayer(personId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, teamList: r));
    });
  }

  Future<void> getDetailMatchByPlayer({required int matchId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _matchesService.getDetailMatchByPlayer(matchId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(
          state.copyWith(screenStatus: ScreenStatus.loaded, detailMatchDTO: r));
    });
  }
}
