import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/domain/team/service/i_team_service.dart';

part 'request_team_by_league_state.dart';

@injectable
class RequestTeamByLeagueCubit extends Cubit<RequestTeamByLeagueState> {
  RequestTeamByLeagueCubit(this._teamService)
      : super(const RequestTeamByLeagueState());

  final ITeamService _teamService;

  Future<void> getRequestTeamByLeague({required int leagueId}) async {
    print("Valor del torneo---->$leagueId");
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _teamService.getRequestTeamByLeague(leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, teamList: r));
    });
  }
}
