import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_eliminatory_dto/qualifying_match_detail_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_detail/match_detail_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/entity/team_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/service/i_team_tournament_service.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/config_league/config_league_interface_dto.dart';

import '../../../../../../core/enums.dart';
import '../../../../../../domain/category/category.dart';
import '../../../../../../domain/countResponse/entity/register_count_interface.dart';
import '../../../../../../domain/matches/dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import '../../../../../../domain/matches/dto/finalize_match_dto/finalize_match_dto.dart';
import '../../../../../../domain/matches/service/i_matches_service.dart';
import '../../../../../../domain/tournament/dto/config_league/config_league_dto.dart';
import '../../../../../../domain/tournament/dto/tournament_champion/tournament_champion_dto.dart';
import '../../../../../../domain/tournament/entity/tournament.dart';
import '../../../../../../domain/tournament/service/i_tournament_service.dart';
import '../../../lm_tournament_v1/teams_tournamens/card_team_obj.dart';

part 'tournament_main_state.dart';

@injectable
class TournamentMainCubit extends Cubit<TournamentMainState> {
  TournamentMainCubit(
    this._service,
    this._categoryService,
    this._matchService,
    this._teamTournamentService,
    this._tournamentService,
  ) : super(const TournamentMainState());

  final ITournamentService _service;
  final ICategoryService _categoryService;
  final IMatchesService _matchService;
  final ITeamTournamentService _teamTournamentService;
  final ITournamentService _tournamentService;

  List<Category> _categoryList = [];
  List<Tournament> _tournamentList = [];
  List<DeatilRolMatchDTO> _matchDetailList = [];
  final List<ResgisterCountInterface> _roundNumberL = [];

  Future<void> onLoadCategories(final int leagueId) async {
    emit(state.copyWith(screenState: LMTournamentScreen.loadingCategories));
    Category category = Category.empty;
    final categoriesRequest =
        await _categoryService.getCategoriesByLeagueId(leagueId);
    _categoryList = categoriesRequest.getOrElse(() => []);
    category = _categoryList.isNotEmpty ? _categoryList.first : Category.empty;
    if (_categoryList.isNotEmpty) {
      final tournamentRequest =
          await _service.getTournamentsListPresidnt(category.categoryId ?? 0);
      _tournamentList = tournamentRequest.getOrElse(() => []);
    }
    emit(state.copyWith(
      categories: _categoryList,
      selectedCategory: category,
      tournaments: _tournamentList,
      screenState: LMTournamentScreen.categoriesLoaded,
    ));
  }

  Future<void> onChangeCategory(Category? category) async {
    if (category == state.selectedCategory) return;
    emit(state.copyWith(
        selectedCategory: category,
        screenState: LMTournamentScreen.loadingTournaments));
    final tournamentRequest =
        await _service.getTournamentsListPresidnt(category?.categoryId ?? 0);
    _tournamentList = tournamentRequest.getOrElse(() => []);
    emit(state.copyWith(
        screenState: LMTournamentScreen.tournamentsLoaded,
        tournaments: tournamentRequest.getOrElse(() => []),
        selectedTournament: Tournament.empty));
  }

  void onSortTournaments(SortingOptions? option) {
    emit(state.copyWith(tournaments: []));
    if (option == SortingOptions.byName) {
      _tournamentList.sort((a, b) => a.tournamentName!
          .toLowerCase()
          .compareTo(b.tournamentName!.toLowerCase()));
    } //else if (option == SortingOptions.byDate) {
    //_tournamentList.sort((a, b) => b.tournamentName!.compareTo(a.tournamentName!));
    //}
    emit(state.copyWith(tournaments: _tournamentList));
  }

  Future<void> onReloadTournaments() async {
    emit(state.copyWith(screenState: LMTournamentScreen.loadingTournaments));
    final tournamentRequest = await _service
        .getTournamentsListPresidnt(state.selectedCategory.categoryId ?? 0);
    _tournamentList = [];
    _tournamentList = tournamentRequest.getOrElse(() => []);
    emit(state.copyWith(
        screenState: LMTournamentScreen.tournamentsLoaded,
        tournaments: tournamentRequest.getOrElse(() => []),
        selectedTournament: Tournament.empty));
  }

  Future<void> onSelectTournament(Tournament tournament) async {
    if (state.screenState == LMTournamentScreen.loadingTable ||
        state.screenState == LMTournamentScreen.loadingTournamentStatus) return;
    if (tournament == state.selectedTournament) return;
    emit(state.copyWith(
      selectedTournament: tournament,
      //selectedMenu: 0,
    ));

    await getTournamentFinishedStatus(tournamentId: tournament.tournamentId!);
    await onLoadGameRolTable();

    validateAndFinishTournament();
  }

  Future<void> onUpdateSelectedTournament(Tournament tournament) async {
    final index = _tournamentList.indexWhere(
        (element) => element.tournamentId == tournament.tournamentId);
    _tournamentList.replaceRange(index, index + 1, [tournament]);
    emit(state.copyWith(
      tournaments: _tournamentList,
      selectedTournament: tournament,
    ));
  }

  Future<void> onLoadGameRolTable() async {
    emit(state.copyWith(
      roundNumberSorting: true,
      screenState: LMTournamentScreen.loadingTable,
      selectedRoundNumber: ResgisterCountInterface.empty,
    ));

    final request = await _matchService
        .getRoundNumberAnpending(state.selectedTournament.tournamentId!);

    _roundNumberL.clear();
    if (request.getOrElse(() => []).isNotEmpty) {
      _roundNumberL.add(ResgisterCountInterface.empty);
    }
    _roundNumberL.addAll(request.getOrElse(() => []));

    final matchRequest = await _matchService.getMatchDetailByTorunamentId(
        state.selectedTournament.tournamentId!, null);

    _matchDetailList = matchRequest.getOrElse(() => []);
    _matchDetailList.sort((a, b) => a.roundNumber!.compareTo(b.roundNumber!));
    final tournamentStatus = _matchDetailList.isNotEmpty
        ? _matchDetailList
            .every((element) => element.score != 'Asignar resultado')
        : false;
    emit(state.copyWith(
      roundNumber: _roundNumberL,
      matches: _matchDetailList,
      statusTournament: tournamentStatus ? 'true' : null,
      selectedMatch: _matchDetailList.firstWhere(
          (element) => element.matchId == state.selectedMatch.matchId,
          orElse: () => DeatilRolMatchDTO.empty),
      screenState: LMTournamentScreen.tableLoaded,
    ));
  }

  Future<void> onSelectRoundNumber(ResgisterCountInterface? round) async {
    if (round == state.selectedRoundNumber) return;
    emit(state.copyWith(
        selectedRoundNumber: round,
        roundNumberSorting: true,
        screenState: LMTournamentScreen.loadingTableFilteredByRound));
    final matchRequest = await _matchService.getMatchDetailByTorunamentId(
        state.selectedTournament.tournamentId ?? 0, round?.coundt1);
    _matchDetailList = matchRequest.getOrElse(() => []);
    _matchDetailList.sort((a, b) => a.roundNumber!.compareTo(b.roundNumber!));
    emit(state.copyWith(
        matches: _matchDetailList,
        screenState: LMTournamentScreen.tableLoaded));
  }

  void onFilterTournaments(String filter) {
    final tournamentsF = _tournamentList
        .where((element) =>
            filter.isEmpty ||
            element.tournamentName!
                .toLowerCase()
                .contains(filter.toLowerCase()))
        .toList();
    emit(state.copyWith(tournaments: tournamentsF));
  }

  void onSortMatches() {
    emit(state.copyWith(matches: []));
    if (state.roundNumberSorting) {
      _matchDetailList.sort((a, b) => b.roundNumber!.compareTo(a.roundNumber!));
    } else {
      _matchDetailList.sort((a, b) => a.roundNumber!.compareTo(b.roundNumber!));
    }
    emit(state.copyWith(
        matches: _matchDetailList,
        roundNumberSorting: !state.roundNumberSorting));
  }

  void onChangeMenu(int? index) {
    if (state.screenState == LMTournamentScreen.loadingTournaments ||
        state.screenState == LMTournamentScreen.loadingTable) return;
    emit(state.copyWith(selectedMenu: index));
    if (index == 2) {
      onLoadGameRolTable();
      // TODO
    }
  }

//qatar
  Future<void> createGameRoles() async {
    print("dentro de create");
    if (state.selectedTournament.tournamentId == null) return;
    print("dentro de create2");
    if (state.screenState == LMTournamentScreen.creatingRoles) return;
    print("dentro de create3");
    emit(state.copyWith(screenState: LMTournamentScreen.creatingRoles));
    print("dentro de create4 ${state.selectedTournament.tournamentId}");
    final response = await _matchService
        .createRolesGamesByTournamentId(state.selectedTournament.tournamentId!);
    print("dentro de create5");
    response.fold(
        (l) => emit(state.copyWith(
            screenState: LMTournamentScreen.errorOnCreatingRoles,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
          screenState: LMTournamentScreen.rolesCreatedSuccessfully));
      print("dentro de create6");
      onLoadGameRolTable();
      print("dentro de create7");
    });
  }

  void onSelectMatch(DeatilRolMatchDTO match) =>
      emit(state.copyWith(selectedMatch: match));

  Future<void> getTournamentFinishedStatus({required int tournamentId}) async {
    emit(state.copyWith(
      screenState: LMTournamentScreen.loadingTournamentStatus,
      statusTournament: 'false',
      configLeagueInterfaceDTO: ConfigLeagueInterfaceDTO.empty,
    ));

    final response = await _service.getTournamentMatchesStatus(tournamentId);

    response.fold(
        (l) => emit(state.copyWith(
            screenState: LMTournamentScreen.error,
            errorMessage: l.errorMessage)), (r) {
      /*if (r == 'true') {
        getConfigLeague(tournamentId: tournamentId);
      }*/
      getConfigLeague(tournamentId: tournamentId);
      emit(state.copyWith(
        screenState: LMTournamentScreen.tournamentStatusLoaded,
        statusTournament: r,
      ));
    });
  }

  void setTournamentStatusToFalse() {
    emit(state.copyWith(statusTournament: 'false'));
  }

  Future<void> validateAndFinishTournament() async {
    List<DeatilRolMatchDTO> auxMatches = [];
    print('>>> ----------------------------------------------------');
    print('>>> ${state.statusTournament}');
    print('>>> ----------------------------------------------------');

    if (state.statusTournament == 'false') {
      auxMatches
          .addAll(state.matches.where((e) => e.score == 'Asignar resultado'));

      emit(state.copyWith(matchesWithoutResult: auxMatches.length));

      if (auxMatches.isEmpty) {
        onUpdateTournamentFinished(
            tournamentId: state.selectedTournament.tournamentId!);
      }
    }
  }

  Future<void> getConfigLeague({required int tournamentId}) async {
    emit(state.copyWith(screenState: LMTournamentScreen.loadingConfigLeague));

    final response = await _service.getLeagueConfiguration(tournamentId);

    response.fold((l) {
      emit(state.copyWith(
        screenState: LMTournamentScreen.error,
        configLeagueInterfaceDTO: ConfigLeagueInterfaceDTO.empty,
        errorMessage: l.errorMessage,
      ));
    }, (r) {
      getQualifiedTeams(tournamentId: tournamentId);
      emit(state.copyWith(
        screenState: LMTournamentScreen.configLeagueLoaded,
        configLeagueInterfaceDTO: r,
      ));
    });
  }

  Future<void> getQualifiedTeams({required int tournamentId}) async {
    emit(state.copyWith(screenState: LMTournamentScreen.loadingQualifiedTeams));

    final response =
        await _teamTournamentService.getQualifiedTeams(tournamentId);

    response.fold((l) {
      emit(state.copyWith(
        screenState: LMTournamentScreen.error,
        errorMessage: l.errorMessage,
      ));
    }, (r) {
      emit(state.copyWith(
        screenState: LMTournamentScreen.qualifiedTeamsLoaded,
        qualifiedTeamsList: r,
      ));
    });
  }

  Future<void> getTeamsTournament({required int tournamentId}) async {
    emit(
        state.copyWith(screenState: LMTournamentScreen.loadingTeamsTournament));
    final response = await _teamTournamentService
        .getTeamTournamentByTournament(tournamentId);

    response.fold(
        (l) => emit(state.copyWith(
            screenState: LMTournamentScreen.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
          screenState: LMTournamentScreen.teamsTournamentLoaded,
          teamsTournament: r));
      //getCountInscribedTeams(tournamentId: tournamentId);
      inscribeTeams(r);
    });
  }

  Future<void> inscribeTeams(List<TeamTournament> teams) async {
    List<CardTeamOBJ> cardTeamsSlc = [];
    teams.forEach((element) {
      CardTeamOBJ crdTeam = CardTeamOBJ(
          imageTeam: '',
          isSelected: false,
          teamName: element.teamId?.teamName,
          teamId: element.teamId?.teamId);
      cardTeamsSlc.add(crdTeam);
    });
    emit(state.copyWith(
      screenState: LMTournamentScreen.teamsTournamentLoaded,
      teamsTournament: teams,
      rounds: Rounds.SEMIFINAL.name,
      matchForRound: MatchForRound.ONEMATCH.name,
      numberOrFinals: MatchForRound.ONEMATCH.name,
      tieBreakerType: TieBreakerType.TABLEPOSITIONS.name,
      cardTeamsSlc: cardTeamsSlc,
      countSelected: 0,
    ));
  }

  Future<void> markTeamToSuscribe(bool val, int index) async {
    int cont = state.countSelected;
    final cardsteams = state.cardTeamsSlc;
    final card = cardsteams[index];

    if (val) {
      cont = cont + 1;
    } else {
      cont = cont - 1;
    }

    emit(state.copyWith(cardTeamsSlc: [], countSelected: 0));
    cardsteams.removeAt(index);
    cardsteams.insert(index, card.copyWith(isSelected: val));

    emit(state.copyWith(cardTeamsSlc: cardsteams, countSelected: cont));
  }

  Future<void> onChangeRound({required int value}) async {
    if (value == 4) {
      emit(state.copyWith(num: value, rounds: Rounds.SEMIFINAL.name));
    } else if (value == 8) {
      emit(state.copyWith(num: value, rounds: Rounds.CUARTOS.name));
    } else if (value == 16) {
      emit(state.copyWith(num: value, rounds: Rounds.OCTAVOS.name));
    } else if (value == 32) {
      emit(state.copyWith(num: value, rounds: Rounds.DIECISEISAVOS.name));
    }
  }

  Future<void> onChangeMatchForRound(String matchForRound) async {
    emit(state.copyWith(matchForRound: matchForRound, rounds: state.rounds));
  }

  Future<void> onChangeNumberOrFinals(String numberOrFinals) async {
    emit(state.copyWith(numberOrFinals: numberOrFinals));
  }

  Future<void> onChangeTieBreakerType(String tieBreakerType) async {
    emit(state.copyWith(tieBreakerType: tieBreakerType));
  }

  Future<void> createRoundsConfiguration({required int tournamentId}) async {
    //emit(state.copyWith(screenState: LMTournamentScreen.loading));
    final config = ConfigLeagueDTO(
        matchForRound: state.matchForRound,
        numberOrFinals: state.numberOrFinals,
        rounds: state.rounds,
        tieBreakerType: state.tieBreakerType,
        tournamentId: tournamentId);
    final response = await _service.createRoundsConfiguration(config);

    response.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.errorMessage,
            screenState: LMTournamentScreen.error)), (r) {
      inscribeLeagueTeams(tournamentId: tournamentId);
    });
  }

  Future<void> inscribeLeagueTeams({required int tournamentId}) async {
    //emit(state.copyWith(screenStatus: CLScreenStatus.loading));
    List<TeamTournament> teamsToInscribe = [];

    if (state.countSelected > 0) {
      state.cardTeamsSlc.forEach((card) {
        if (card.isSelected!) {
          int index = state.teamsTournament
              .indexWhere((element) => element.teamId?.teamId == card.teamId);
          TeamTournament team = state.teamsTournament[index];
          teamsToInscribe.add(team);
        }
      });
      final response =
          await _service.inscribeLeagueTeams(teamsToInscribe, tournamentId);

      response.fold((l) {
        emit(state.copyWith(
            screenState: LMTournamentScreen.error,
            errorMessage: l.errorMessage));
      }, (r) {
        emit(state.copyWith(
            screenState: LMTournamentScreen.createdConfiguration));
      });
    } else {
      emit(state.copyWith(
          screenState: LMTournamentScreen.teamsTournamentLoaded));
    }
  }

  Future<void> getTournamentFinishedStatus2({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: CLScreenStatus2.loading));
    final response =
        await _tournamentService.getTournamentMatchesStatus(tournamentId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus2.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
          screenStatus: CLScreenStatus2.loaded, statusTournament: r));
    });
  }

  Future<void> onUpdateTournamentFinished({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: CLScreenStatus2.loading));
    final request = await _tournamentService.tournamentFinished(tournamentId);
    request.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus2.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: CLScreenStatus2.loaded, ttDTO: r));
    });
  }

  Future<void> getTournamentChampion({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: CLScreenStatus2.loading));
    final response =
        await _tournamentService.getTournamentChampion(tournamentId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: CLScreenStatus2.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
          screenStatus: CLScreenStatus2.loaded, nameCh: r.teamName));
    });
  }

  Future<void> asingDataFinalize(DeatilRolMatchDTO deatilRolMatchDTO) async {
    emit(state.copyWith(
        finalizeMatchDTO: state.finalizeMatchDTO.copyWith(
          matchId: deatilRolMatchDTO.matchId,
          teamMatchLocal: deatilRolMatchDTO.teamMatchLocalId,
          teamMatchVisit: deatilRolMatchDTO.teamMatchVisitId,
          scoreLocal: 0,
          scoreVist: 0,
          scoreShoutoutLocal: 0,
          scoreShoutoutVisit: 0,
        ),
        screenStatus: CLScreenStatus2.loadingDataToFinish));

    onSelectMatch(deatilRolMatchDTO);

    await getMatchDetail(matchId: deatilRolMatchDTO.matchId!);

    await getDetailEliminatory(matchId: deatilRolMatchDTO.matchId!);

    validateTiebreakerRequired();

    validateDataToFinish();

    emit(state.copyWith(screenStatus: CLScreenStatus2.dataToFinishLoaded));
  }

  Future<void> increaseScore({
    required TypeMatchTem typeTeam,
    required bool isShoutout,
  }) async {
    log('inicia > increaseScore');
    int score;
    if (typeTeam == TypeMatchTem.local) {
      print('local');
      if (isShoutout) {
        print('is Shoutout');
        score = state.finalizeMatchDTO.scoreShoutoutLocal ?? 0;
        score = score + 1;

        print('score $score');
        emit(state.copyWith(
          finalizeMatchDTO:
              state.finalizeMatchDTO.copyWith(scoreShoutoutLocal: score),
        ));
        print(
            'scoreShoutoutLocal ${state.finalizeMatchDTO.scoreShoutoutLocal}');
      } else {
        score = state.finalizeMatchDTO.scoreLocal ?? 0;
        score = score + 1;
        emit(state.copyWith(
          finalizeMatchDTO: state.finalizeMatchDTO.copyWith(scoreLocal: score),
        ));
      }
    } else {
      print('visit');
      if (isShoutout) {
        print('is Shoutout');
        score = state.finalizeMatchDTO.scoreShoutoutVisit ?? 0;
        score = score + 1;
        emit(state.copyWith(
          finalizeMatchDTO:
              state.finalizeMatchDTO.copyWith(scoreShoutoutVisit: score),
        ));
      } else {
        score = state.finalizeMatchDTO.scoreVist ?? 0;
        score = score + 1;
        emit(state.copyWith(
          finalizeMatchDTO: state.finalizeMatchDTO.copyWith(scoreVist: score),
        ));
      }
    }

    validateDataToFinish();
  }

  Future<void> decreaseScore({
    required TypeMatchTem typeTeam,
    required bool isShoutout,
  }) async {
    log('inicia > decreaseScore');
    int score;
    if (typeTeam == TypeMatchTem.local) {
      if (isShoutout) {
        score = state.finalizeMatchDTO.scoreShoutoutLocal ?? 0;
        if (score == 0) {
          return;
        } else {
          emit(state.copyWith(
            finalizeMatchDTO:
                state.finalizeMatchDTO.copyWith(scoreShoutoutLocal: score - 1),
          ));
        }
      } else {
        score = state.finalizeMatchDTO.scoreLocal ?? 0;
        if (score == 0) {
          return;
        } else {
          emit(state.copyWith(
            finalizeMatchDTO:
                state.finalizeMatchDTO.copyWith(scoreLocal: score - 1),
          ));
        }
      }
    } else {
      if (isShoutout) {
        score = state.finalizeMatchDTO.scoreShoutoutVisit ?? 0;
        if (score == 0) {
          return;
        } else {
          emit(state.copyWith(
            finalizeMatchDTO:
                state.finalizeMatchDTO.copyWith(scoreShoutoutVisit: score - 1),
          ));
        }
      } else {
        score = state.finalizeMatchDTO.scoreVist ?? 0;
        if (score == 0) {
          return;
        } else {
          emit(state.copyWith(
            finalizeMatchDTO:
                state.finalizeMatchDTO.copyWith(scoreVist: score - 1),
          ));
        }
      }
    }

    validateDataToFinish();
  }

  Future<void> finalizeMatch() async {
    emit(state.copyWith(screenStatus: CLScreenStatus2.loading));

    final response = await _matchService.finalizeMatch(state.finalizeMatchDTO);
    response.fold(
      (l) => emit(state.copyWith(screenStatus: CLScreenStatus2.error)),
      (r) {
        //getMatchDetailByTournamnet(),
        emit(state.copyWith(
          screenStatus: CLScreenStatus2.matchFinalized,
        ));
        onLoadGameRolTable();
      },
    );
  }

  Future<void> getMatchDetail({required int matchId}) async {
    emit(state.copyWith(matchStatus: MatchStatus.loading));

    final request = await _matchService.getMatchDetail(matchId);

    request.fold(
      (l) {
        emit(state.copyWith(
          matchStatus: MatchStatus.error,
          errorMessage: l.errorMessage,
        ));
      },
      (r) {
        emit(state.copyWith(
          matchStatus: MatchStatus.loaded,
          matchDetail: r,
        ));
      },
    );
  }

  void validateDataToFinish() {
    log('inicio validateDataToFinish');
    int auxCountLocal = 0, auxCountVisit = 0;
    bool flag = false;

    auxCountLocal = (state.finalizeMatchDTO.scoreLocal ?? 0) +
        (state.qualifyingMatchDetail?.scoreLocal ?? 0);

    auxCountVisit = (state.finalizeMatchDTO.scoreVist ?? 0) +
        (state.qualifyingMatchDetail?.scoreVisit ?? 0);

    if (auxCountLocal != auxCountVisit) {
      emit(state.copyWith(
        finalizeMatchDTO: state.finalizeMatchDTO.copyWith(
          scoreShoutoutLocal: 0,
          scoreShoutoutVisit: 0,
        ),
      ));
    }

    emit(state.copyWith(
        tiebreakerRequired:
            (auxCountLocal == auxCountVisit) && state.haveConfigShootout));

    if (state.tiebreakerRequired) {
      flag = ((state.finalizeMatchDTO.scoreShoutoutLocal! <
              state.finalizeMatchDTO.scoreShoutoutVisit!) ||
          (state.finalizeMatchDTO.scoreShoutoutLocal! >
              state.finalizeMatchDTO.scoreShoutoutVisit!));
    } else {
      flag = true;
    }

    print('canFinish $flag');

    emit(state.copyWith(canFinish: flag));

    log('fin validateDataToFinish');
  }

  Future<void> getDetailEliminatory({required int matchId}) async {
    emit(state.copyWith(
      screenState: LMTournamentScreen.loadingQualifyingMatchDetail,
    ));

    final response = await _matchService.getDetailEliminatory(matchId);

    response.fold(
      (l) => emit(state.copyWith(
        screenState: LMTournamentScreen.error,
        errorMessage: l.errorMessage,
      )),
      (r) {
        print('MATCH ELIMINATORY --> $r');
        emit(state.copyWith(
          screenState: LMTournamentScreen.qualifyingMatchDetailLoaded,
          qualifyingMatchDetail: r,
        ));
      },
    );
  }

  void validateTiebreakerRequired() {
    log('inicia > validateTiebreakerRequired');
    bool isRequired = false;

    if (state.selectedMatch.roundNumber! != 0) {
      print('match.jornada DIF 0');
      if (state.selectedTournament.scoringSystemId?.pointsPerWinShootOut !=
              null &&
          state.selectedTournament.scoringSystemId?.pointPerLossShootOut !=
              null) {
        emit(state.copyWith(
          haveConfigShootout: (state.selectedTournament.scoringSystemId!
                      .pointsPerWinShootOut! >
                  0 &&
              state.selectedTournament.scoringSystemId!.pointPerLossShootOut! >
                  0),
        ));
        print('empate shootout');
        isRequired = true;
      } else {
        print('sin empate');
      }
    } else {
      print('ELSE match.jornada DIF 0');
      if (state.qualifyingMatchDetail?.tieBreakType == 2) {
        print('tieBreakType 2');
        if (state.qualifyingMatchDetail?.roundtrip == 1) {
          print('roundtrip 1');
          isRequired = true;
        } else if ((state.qualifyingMatchDetail?.scoreLocal ==
                state.qualifyingMatchDetail?.scoreVisit) &&
            state.qualifyingMatchDetail?.roundtrip ==
                state.qualifyingMatchDetail?.matchNumber) {
          print('IDA Y VUELTA + MARCADOR EMPATADO');
          isRequired = true;
        } else if (state.qualifyingMatchDetail?.rounName == 'Final' &&
            state.qualifyingMatchDetail?.numberFinalsGame == 1) {
          print('FINAL IDA + MARCADOR EMPATADO');
          isRequired = true;
        } else if (state.qualifyingMatchDetail?.rounName == 'Final' &&
            state.qualifyingMatchDetail?.numberFinalsGame == 2 &&
            state.qualifyingMatchDetail?.matchNumber == 2) {
          print('FINAL IDA Y VUELTA + MARCADOR EMPATADO');
          isRequired = true;
        } else {
          print('ELSE tieBreakType');
        }
      } else {
        print('ELSE tieBreakType 2');
      }
    }

    print('tiebreakerRequired : $isRequired');

    emit(state.copyWith(tiebreakerRequired: isRequired));
  }

  void log(data) {
    String mssg;
    mssg = '>>> ----------------------------------------------------------';
    mssg += '\n>>> $data';
    mssg += '\n>>> ----------------------------------------------------------';
    print(mssg);
  }

  bool validateTournamentType() {
    final type = state.selectedTournament.typeTournament;
    if (type == '2') {
      if (state.configLeagueInterfaceDTO.isEmpty) {
        return false;
      } else {
        return state.statusTournament == 'true';
      }
    } else {
      return state.statusTournament == 'true';
    }
  }
}
