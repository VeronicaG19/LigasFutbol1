import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/entity/player_by_team.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/service/i_team_player_service.dart';

part 'team_players_lm_state.dart';

@injectable
class TeamPlayersLmCubit extends Cubit<TeamPlayersLMState> {
  TeamPlayersLmCubit(this._teamPlayerService) : super(TeamPlayersLMState());

  final ITeamPlayerService _teamPlayerService;

  Future<void> getTeamPlayer({required int teamId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _teamPlayerService.getPlayersByTeam(teamId);
    response.fold(
        (l) => {
              emit(state.copyWith(
                  screenStatus: ScreenStatus.loaded,
                  errorMessage: l.errorMessage)),
              print("Error ${l.errorMessage}")
            }, (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, teamPlayer: r));
    });
  }
}
