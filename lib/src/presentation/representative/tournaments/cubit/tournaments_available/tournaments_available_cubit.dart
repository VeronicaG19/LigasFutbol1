import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/leagues.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/getOpenTournamentsInterface/get_open_tournaments_interface.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/service/i_tournament_service.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/service/i_user_requests_service.dart';

part 'tournaments_available_state.dart';

@injectable
class TournamentsAvailableCubit extends Cubit<TournamentsAvailableState> {
  TournamentsAvailableCubit(
    this._leagueService,
    this._tournamentService,
    this._userRequestsService,
  ) : super(const TournamentsAvailableState());

  final ILeagueService _leagueService;
  final ITournamentService _tournamentService;
  final IUserRequestsService _userRequestsService;

  Future<void> getAllLeagues({int? teamId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _leagueService.getAllLeagues();

    response.fold(
      (l) => emit(
        state.copyWith(
          screenStatus: ScreenStatus.error,
          errorMessage: l.errorMessage,
        ),
      ),
      (r) {
        print("Lista de ligas ---> ${r.length}");
        r.add(const League(
          leagueStatus: "",
          leagueId: 0,
          leagueName: "",
          presidentId: 0,
          publicFlag: "",
        ));
        r.sort((a, b) => a.leagueId.compareTo(b.leagueId));
        emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          leaguesList: r,
        ));

        getTournamentsByTeam(teamId: teamId!);
      },
    );
  }

  Future<void> getTournamentsByTeam({
    required int teamId,
  }) async {
    emit(
        state.copyWith(screenStatus: ScreenStatus.loadingAvailableTournaments));
    final response =
        await _tournamentService.getAvailableTournamentsByTeamId(teamId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Lista de equipos---> ${r.length}");
      emit(state.copyWith(
        screenStatus: ScreenStatus.availableTournamentsLoaded,
        tournamentsList: r,
      ));
    });
  }

  Future<void> getTournamentsByTeamAndLeague({
    required int teamId,
    int? leagueId,
    int? selectedIndex,
  }) async {
    emit(
        state.copyWith(screenStatus: ScreenStatus.loadingAvailableTournaments));
    final response = await _tournamentService
        .getTournamentsByTeamIdAndLeagueId(teamId, leagueId: leagueId!);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Lista de equipos---> ${r.length}");
      emit(state.copyWith(
        screenStatus: ScreenStatus.availableTournamentsLoaded,
        indexLeagueSelec: selectedIndex,
        tournamentsList: r,
      ));
    });
  }

  Future<void> sendTournamentRegistrationRequest({
    required int tournamentId,
    required int teamId,
  }) async {
    emit(state.copyWith(screenStatus: ScreenStatus.sendingRequest));
    final response = await _userRequestsService
        .sendTournamentRegistrationRequest(tournamentId, teamId);
    return response.fold(
      (l) => emit(state.copyWith(
        screenStatus: ScreenStatus.sendError,
        errorMessage: l.errorMessage,
      )),
      (r) {
        getTournamentsByTeamAndLeague(
          teamId: teamId,
          leagueId: state.tournamentsList[state.indexLeagueSelec!].leagueId,
          selectedIndex: state.indexLeagueSelec,
        );
        emit(state.copyWith(
          screenStatus: ScreenStatus.requestSend,
        ));
      },
    );
  }
}
