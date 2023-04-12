import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/entity/team_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/service/i_team_tournament_service.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/config_league/config_league_interface_dto.dart';

import '../../../../../../core/enums.dart';
import '../../../../../../domain/category/category.dart';
import '../../../../../../domain/countResponse/entity/register_count_interface.dart';
import '../../../../../../domain/matches/dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import '../../../../../../domain/matches/service/i_matches_service.dart';
import '../../../../../../domain/tournament/dto/config_league/config_league_dto.dart';
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
  ) : super(const TournamentMainState());

  final ITournamentService _service;
  final ICategoryService _categoryService;
  final IMatchesService _matchService;
  final ITeamTournamentService _teamTournamentService;

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

  Future<void> onSelectTournament(Tournament tournament) async {
    if (state.screenState == LMTournamentScreen.loadingTable) return;
    if (tournament == state.selectedTournament) return;
    emit(state.copyWith(
      selectedTournament: tournament,
      //selectedMenu: 0,
    ));
    if (state.selectedMenu == 2) {
      await onLoadGameRolTable();
      getTournamentFinishedStatus(tournamentId: tournament.tournamentId!);
    } else {
      getTournamentFinishedStatus(tournamentId: tournament.tournamentId!);
    }
  }

  void onUpdateSelectedTournament(Tournament tournament) {
    final index = _tournamentList.indexWhere(
        (element) => element.tournamentId == tournament.tournamentId);
    _tournamentList.replaceRange(index, index + 1, [tournament]);
    emit(state.copyWith(
        tournaments: _tournamentList, selectedTournament: tournament));
  }

  Future<void> onLoadGameRolTable() async {
    emit(state.copyWith(
        roundNumberSorting: true,
        screenState: LMTournamentScreen.loadingTable,
        selectedRoundNumber: ResgisterCountInterface.empty));
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
    emit(state.copyWith(
        roundNumber: _roundNumberL,
        matches: _matchDetailList,
        screenState: LMTournamentScreen.tableLoaded));
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
      if (r == 'true') {
        getConfigLeague(tournamentId: tournamentId);
      }
      emit(state.copyWith(
        screenState: LMTournamentScreen.tournamentStatusLoaded,
        statusTournament: r,
      ));
    });
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
        cardTeamsSlc: cardTeamsSlc));
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
        emit(
            state.copyWith(screenState: LMTournamentScreen.createdConfiguration));
      });
    } else {
      emit(state.copyWith(
          screenState: LMTournamentScreen.teamsTournamentLoaded));
    }
  }
}
