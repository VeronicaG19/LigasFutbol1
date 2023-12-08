import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/entity/league.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/service/i_league_service.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/service/i_tournament_service.dart';

part 'league_state.dart';

@injectable
class LeagueCubit extends Cubit<LeagueState> {
  LeagueCubit(this._service, this._tournamentService)
      : super(const LeagueState());

  final ILeagueService _service;
  final ITournamentService _tournamentService;
  Future<void> loadLeagues() async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    League league = League.empty;

    final response = await _service.getAllLeagues(requiresAuthToken: false);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) async {
      league = r.isNotEmpty ? r.first : League.empty;
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          leagueList: r,
          selectedValue: league));
      await getTournamentByLeagueId(league.leagueId);
    });
  }

  Future<void> getTournamentByLeagueId(int leagueId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _tournamentService.getTournamentByLeagueId(leagueId,
        requiresAuthToken: false);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(
          state.copyWith(screenStatus: ScreenStatus.loaded, tournamentList: r));
    });
  }
}
