import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/service/i_team_tournament_service.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/service/i_tournament_service.dart';

import '../../../../../../core/enums.dart';
import '../../../../../../domain/agenda/agenda.dart';
import '../../../../../../domain/countResponse/entity/register_count_interface.dart';
import '../../../../../../domain/field/entity/field.dart';
import '../../../../../../domain/field/service/i_field_service.dart';
import '../../../../../../domain/matches/dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import '../../../../../../domain/matches/dto/edit_match_dto/edit_match_dto.dart';
import '../../../../../../domain/matches/dto/finalize_match_dto/finalize_match_dto.dart';
import '../../../../../../domain/matches/service/i_matches_service.dart';
import '../../../../../../domain/referee/entity/referee_by_league_dto.dart';
import '../../../../../../domain/referee/service/i_referee_service.dart';
import '../../../../../../domain/scoring_system/entity/scoring_system.dart';
import '../../../../../../domain/scoring_system/service/i_scoring_system_service.dart';
import '../../../../../../domain/team_tournament/entity/team_tournament.dart';
import '../../../../../../domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';
import '../../../../../../domain/tournament/dto/tournament_champion/tournament_champion_dto.dart';
import '../../../../../../domain/tournament/entity/tournament.dart';
import '../../../../../../domain/user_requests/service/i_user_requests_service.dart';
import '../../teams_tournamens/card_team_obj.dart';

part 'clasification_state.dart';

@injectable
class ClasificationCubit extends Cubit<ClasificationState> {
  ClasificationCubit(
    this._service,
    this._matchService,
    this._tournamentService,
    this._refereeService,
    this._fieldService,
    this._requestService,
    this._agendaService,
    this._iTeamTournamentService,
  ) : super(const ClasificationState());

  final IScoringSystemService _service;
  final IMatchesService _matchService;
  final ITournamentService _tournamentService;
  final IRefereeService _refereeService;
  final IFieldService _fieldService;
  final IUserRequestsService _requestService;
  final IAgendaService _agendaService;
  final ITeamTournamentService _iTeamTournamentService;

  int? _roundNumber;

  Future<void> getScoringSystem({required Tournament tournament}) async {
    print('>>> ----------------------------------------------------');
    print('>>> getScoringSystem');
    print('>>> ----------------------------------------------------');

    emit(state.copyWith(screenStatus: CLScreenStatus.loading));
    final response =
        await _service.getScoringSystemByTournament(tournament.tournamentId!);

    response.fold(
      (l) => emit(state.copyWith(
          screenStatus: CLScreenStatus.error, errorMessage: l.errorMessage)),
      (r) {
        bool shooout = ((r.pointsPerWinShootOut != null) &&
            r.pointPerLossShootOut != null);

        emit(state.copyWith(
          scoringSystem: r,
          tournament: tournament,
          shootout: shooout,
          scoringSystem2: r,
        ));

        getRoundsListByTournament(state.tournament.tournamentId!);

        if (shooout) {
          getScoringTournamentIdShootOut(
              tournamentId: tournament.tournamentId!);
        } else {
          getScoringTournamentId(tournamentId: tournament.tournamentId!);
        }

        getMatchDetailByTournamnet();
        getTournamentFinishedStatus(tournamentId: tournament.tournamentId!);
        getTournamentChampion(tournamentId: tournament.tournamentId!);
        // getTeamsTournament(tournamentId: tournament.tournamentId!);
      },
    );
  }

  Future<void> getScoreData(final int? tournamentId) async {
    final scoreSystem =
        await _service.getScoringSystemByTournament(tournamentId ?? 0);
    final ScoringSystem score =
        scoreSystem.getOrElse(() => ScoringSystem.empty);
    // final tournamentScore =
    //     await _tournamentService.getScoringTournamentId(tournamentId ?? 0);
    final tournamentMatchStatus =
        await _tournamentService.getTournamentMatchesStatus(tournamentId ?? 0);
    final tournamentChampion =
        await _tournamentService.getTournamentChampion(tournamentId ?? 0);
    emit(state.copyWith(
        scoringSystem: score,
        scoringSystem2: score,
        shootout: score.pointsPerWinShootOut != null,
        statusTournament: tournamentMatchStatus.getOrElse(() => 'false'),
        nameCh: tournamentChampion
            .getOrElse(() => TournamentChampionDTO.empty)
            .teamName));
  }

  Future<void> getScoringTournamentId({required int tournamentId}) async {
    print("Valor del torneo---->$tournamentId");
    emit(state.copyWith(screenStatus: CLScreenStatus.loading));

    final response =
        await _tournamentService.getScoringTournamentId(tournamentId);

    response.fold(
      (l) => emit(state.copyWith(
          screenStatus: CLScreenStatus.error,
          scoringTournament: [],
          errorMessage: l.errorMessage)),
      (r) {
        emit(state.copyWith(
            screenStatus: CLScreenStatus.loaded, scoringTournament: r));
      },
    );
  }

  Future<void> getScoringTournamentIdShootOut(
      {required int tournamentId}) async {
    final response =
        await _iTeamTournamentService.getGeneralTableByTournament(tournamentId);

    response.fold(
      (l) {
        emit(state.copyWith(
          screenStatus: CLScreenStatus.error,
          scoringTournament: [],
          errorMessage: l.errorMessage,
        ));
      },
      (r) {
        emit(state.copyWith(
            screenStatus: CLScreenStatus.loaded, scoringTournament: r));
      },
    );
  }

  Future<void> getMatchDetailByTournamnet({int? roundNumber}) async {
    _roundNumber = roundNumber;
    emit(state.copyWith(screenStatus: CLScreenStatus.loading));
    final response = await _matchService.getMatchDetailByTorunamentId(
        state.tournament.tournamentId!, roundNumber);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: CLScreenStatus.loaded, dailMaitch: r));
    });
  }

  Future<void> getRoundsListByTournament(int tournamentId) async {
    emit(state.copyWith(screenStatus: CLScreenStatus.loading));
    final response = await _matchService.getRoundNumberAnpending(tournamentId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: CLScreenStatus.loaded, roundList: r));
    });
  }

  Future<void> onchangeShooOut(bool val) async {
    emit(state.copyWith(shootout: val));
  }

  Future<void> updateWin(String val) async {
    emit(state.copyWith(
        scoringSystem:
            state.scoringSystem.copyWith(pointsPerWin: int.parse(val))));
  }

  Future<void> updateTie(String val) async {
    emit(state.copyWith(
        scoringSystem:
            state.scoringSystem.copyWith(pointPerTie: int.parse(val))));
  }

  Future<void> updateWinShoot(String val) async {
    emit(state.copyWith(
        scoringSystem: state.scoringSystem
            .copyWith(pointsPerWinShootOut: int.parse(val))));
  }

  Future<void> updateLoosShootout(String val) async {
    emit(state.copyWith(
        scoringSystem: state.scoringSystem
            .copyWith(pointPerLossShootOut: int.parse(val))));
  }

  Future<void> onCancelUpdate() async {
    emit(state.copyWith(scoringSystem: state.scoringSystem2));
  }

  Future<void> onUpdateSoring() async {
    emit(state.copyWith(screenStatus: CLScreenStatus.loading));
    ScoringSystem score = state.scoringSystem;
    if (!state.shootout) {
      score = ScoringSystem(
          scoringSystemId: state.scoringSystem.scoringSystemId,
          pointPerLoss: state.scoringSystem.pointPerLoss,
          pointPerTie: state.scoringSystem.pointPerTie,
          pointsPerWin: state.scoringSystem.pointsPerWin,
          pointPerLossShootOut: 0,
          pointsPerWinShootOut: 0);
    }
    final response = await _service.updateScoringSystem(score);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
          screenStatus: CLScreenStatus.loaded,
          shootout:
              r.pointsPerWinShootOut != null && r.pointPerLossShootOut != null,
          scoringSystem: r,
          scoringSystem2: r));
    });
  }

  Future<void> createRoleGame() async {
    emit(state.copyWith(screenStatus: CLScreenStatus.creatingRoleGame));

    final response = await _matchService
        .createRolesGamesByTournamentId(state.tournament.tournamentId!);

    response.fold((l) {
      emit(state.copyWith(
          screenStatus: CLScreenStatus.error, errorMessage: l.errorMessage));
      getMatchDetailByTournamnet();
    },
        (r) => {
              getMatchDetailByTournamnet(),
              emit(state.copyWith(
                screenStatus: CLScreenStatus.createdRoleGame,
              ))
            });
  }

  Future<void> asingDataFinalize(DeatilRolMatchDTO deatilRolMatchDTO) async {
    emit(state.copyWith(
        finalizeMatchDTO: state.finalizeMatchDTO.copyWith(
            matchId: deatilRolMatchDTO.matchId,
            teamMatchLocal: deatilRolMatchDTO.teamMatchLocalId,
            teamMatchVisit: deatilRolMatchDTO.teamMatchVisitId,
            scoreLocal: 0,
            scoreVist: 0)));
  }

  Future<void> increaseScore(TypeMatchTem typeTeam) async {
    int score;
    if (typeTeam == TypeMatchTem.local) {
      score = state.finalizeMatchDTO.scoreLocal ?? 0;
      print('$score');
      score = score + 1;
      emit(state.copyWith(
          finalizeMatchDTO:
              state.finalizeMatchDTO.copyWith(scoreLocal: score)));
    } else {
      score = state.finalizeMatchDTO.scoreVist ?? 0;
      score = score + 1;
      print('$score');
      emit(state.copyWith(
          finalizeMatchDTO: state.finalizeMatchDTO.copyWith(scoreVist: score)));
    }
  }

  Future<void> decreaseScore(TypeMatchTem typeTeam) async {
    int score;
    if (typeTeam == TypeMatchTem.local) {
      score = state.finalizeMatchDTO.scoreLocal ?? 0;
      print('$score');
      if (score == 0) {
        return;
      } else {
        emit(state.copyWith(
            finalizeMatchDTO:
                state.finalizeMatchDTO.copyWith(scoreLocal: score - 1)));
      }
    } else {
      score = state.finalizeMatchDTO.scoreVist ?? 0;
      print('$score');
      if (score == 0) {
        return;
      } else {
        emit(state.copyWith(
            finalizeMatchDTO:
                state.finalizeMatchDTO.copyWith(scoreVist: score - 1)));
      }
    }
  }

  Future<void> finalizeMatch() async {
    emit(state.copyWith(screenStatus: CLScreenStatus.loading));
    final response = await _matchService.finalizeMatch(state.finalizeMatchDTO);
    response.fold(
        (l) => null,
        (r) => {
              //getMatchDetailByTournamnet(),
              emit(state.copyWith(
                screenStatus: CLScreenStatus.matchFinalized,
              ))
            });
  }

  Future<void> loadReferee({required int leagueId}) async {
    emit(state.copyWith(screenStatus: CLScreenStatus.refereetListLing));
    final response = await _refereeService.getRefereeByLeague1(leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(
          screenStatus: CLScreenStatus.refereetListLoaded, refereetList: r));
    });
  }

  Future<void> loadfields({required int leagueId}) async {
    emit(state.copyWith(screenStatus: CLScreenStatus.fieldtListLoading));
    final response = await _fieldService.getFieldsByLeagueId(leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(
          screenStatus: CLScreenStatus.fieldtListLoaded, fieldtList: r));
    });
  }

  Future<void> asignDataToObjEditMatch(DeatilRolMatchDTO obj) async {
    print(obj.toString());
    emit(state.copyWith(
        editMatchObj: state.editMatchObj.copyWith(
            dateMatch: (obj.dateMatch != null)
                ? DateFormat('dd-MM-yyyy HH:mm').parse(obj.dateMatch!)
                : null,
            fieldId: obj.fieldMatchId,
            matchId: obj.matchId,
            refereeId: obj.refereeId)));
  }

  Future<void> onChangeReferee(int refereeId) async {
    emit(state.copyWith(
        editMatchObj: state.editMatchObj.copyWith(refereeId: refereeId)));
  }

  Future<void> onChangeField(int fieldId) async {
    emit(state.copyWith(
        editMatchObj: state.editMatchObj.copyWith(fieldId: fieldId)));
  }

  Future<void> onChangeDateMatch(DateTime date) async {
    emit(state.copyWith(
        editMatchObj: state.editMatchObj.copyWith(dateMatch: date)));
  }

  Future<void> onChangeHourMatch(DateTime hpur) async {
    emit(state.copyWith(
        editMatchObj:
            state.editMatchObj.copyWith(hourMatch: hpur, dateMatch: hpur)));
  }

  Future<void> updateMatch() async {
    emit(state.copyWith(screenStatus: CLScreenStatus.loading));
    final response = await _matchService.editMatchDto(state.editMatchObj);
    response.fold(
        (l) => getMatchDetailByTournamnet(),
        (r) => {
              getMatchDetailByTournamnet(),
              emit(state.copyWith(
                screenStatus: CLScreenStatus.loaded,
              ))
            });
  }

  Future<void> deleteMatch() async {
    emit(state.copyWith(screenStatus: CLScreenStatus.loading));
    final response =
        await _matchService.deleteMatch(state.editMatchObj.matchId!);
    response.fold(
        (l) => null,
        (r) => {
              getMatchDetailByTournamnet(),
              emit(state.copyWith(
                screenStatus: CLScreenStatus.loaded,
              ))
            });
  }

  Future<void> cleanDataToObjEditMatch() async {
    emit(state.copyWith(editMatchObj: EditMatchDTO.empty));
  }

  Future<void> onGetRentalActive(LMRequestType type, int leagueId) async {
    if (type.name == LMRequestType.fieldOwner.name) {
      final fields = await _fieldService.getRentalFields();
      emit(state.copyWith(
          rentalFields: fields,
          selectedRentalField: fields.isNotEmpty ? fields.first : Field.empty));
    } else {
      final referee = await _refereeService.getRefereeByLeague2(leagueId);
      emit(state.copyWith(
          availabilityReferee: referee,
          selectedReferee:
              referee.isNotEmpty ? referee.first : RefereeByLeagueDTO.empty));
    }
  }

  void onChangeSelectedRentalField(Field? field) {
    emit(state.copyWith(selectedRentalField: field ?? Field.empty));
  }

  void onChangeSelectedReferee(RefereeByLeagueDTO? field) {
    emit(state.copyWith(selectedReferee: field ?? RefereeByLeagueDTO.empty));
  }

  Future<void> onCancelRequest(final int requestId) async {
    emit(state.copyWith(screenStatus: CLScreenStatus.submissionInProgress));
    final response = await _requestService.cancelUserRequest(requestId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus.submissionFailure,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: CLScreenStatus.submissionSuccess));
      getMatchDetailByTournamnet(roundNumber: _roundNumber);
    });
  }

  Future<void> onUpdateMatchDate(
      DateTime? day, DateTime? time, int? matchId) async {
    emit(state.copyWith(screenStatus: CLScreenStatus.submissionInProgress));
    if (day == null || time == null) {
      emit(state.copyWith(
          screenStatus: CLScreenStatus.submissionFailure,
          errorMessage: 'Selecciona la hora y fecha'));
      return;
    }
    final dateTime =
        DateTime(day.year, day.month, day.day, time.hour, time.minute);
    final request =
        await _matchService.updateMatchDate(dateTime, dateTime, matchId ?? 0);
    request.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus.submissionFailure,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: CLScreenStatus.submissionSuccess));
      getMatchDetailByTournamnet(roundNumber: _roundNumber);
    });
  }

  Future<void> onUpdateMatchField(DeatilRolMatchDTO match) async {
    emit(state.copyWith(screenStatus: CLScreenStatus.submissionInProgress));
    final fieldAvailability = await _agendaService
        .getFieldsAvailability(state.selectedRentalField.activeId ?? 0);
    final availability = fieldAvailability.getOrElse(() => []);
    bool flag = false;
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    for (final e in availability) {
      if (dateFormat.parse(match.dateMatch!).isAfter(e.openingDate!) &&
          dateFormat.parse(match.dateMatch!).isBefore(e.expirationDate!)) {
        flag = true;
      }
    }
    if (!flag) {
      emit(state.copyWith(
          screenStatus: CLScreenStatus.submissionFailure,
          errorMessage:
              'Este campo no está disponible para la fecha ${match.dateMatch}'));
      return;
    }
    final request = await _matchService.updateMatchField(
        match.matchId ?? 0, state.selectedRentalField.fieldId ?? 0);
    request.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus.submissionFailure,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: CLScreenStatus.submissionSuccess));
      getMatchDetailByTournamnet(roundNumber: _roundNumber);
    });
  }

  Future<void> onUpdateReferee(DeatilRolMatchDTO match) async {
    emit(state.copyWith(screenStatus: CLScreenStatus.submissionInProgress));
    final fieldAvailability = await _agendaService
        .getRefereeAvailability(state.selectedReferee.refereeId);
    final availability = fieldAvailability.getOrElse(() => []);
    bool flag = false;
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    for (final e in availability) {
      if (dateFormat.parse(match.dateMatch!).isAfter(e.openingDate!) &&
          dateFormat.parse(match.dateMatch!).isBefore(e.expirationDate!)) {
        flag = true;
      }
    }
    if (!flag) {
      emit(state.copyWith(
          screenStatus: CLScreenStatus.submissionFailure,
          errorMessage:
              'El árbitro no está disponible para la fecha ${match.dateMatch}'));
      return;
    }
    final request = await _matchService.updateMatchReferee(
        match.matchId ?? 0, state.selectedReferee.refereeId);
    request.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus.submissionFailure,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: CLScreenStatus.submissionSuccess));
      getMatchDetailByTournamnet(roundNumber: _roundNumber);
    });
  }

  Future<void> getTournamentFinishedStatus({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: CLScreenStatus.loading));
    final response =
        await _tournamentService.getTournamentMatchesStatus(tournamentId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(
          screenStatus: CLScreenStatus.loaded, statusTournament: r));
    });
  }

  Future<void> onUpdateTournamentFinished({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: CLScreenStatus.loading));
    final request = await _tournamentService.tournamentFinished(tournamentId);
    request.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: CLScreenStatus.loaded, ttDTO: r));
    });
  }

  Future<void> getTournamentChampion({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: CLScreenStatus.loading));
    final response =
        await _tournamentService.getTournamentChampion(tournamentId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
          screenStatus: CLScreenStatus.loaded, nameCh: r.teamName));
    });
  }
}
