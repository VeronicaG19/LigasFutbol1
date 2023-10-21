import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/leagues/leagues.dart';
import '../../../../../domain/match_event/dto/referee_match_event/referee_global_statics.dart';
import '../../../../../domain/match_event/service/i_match_event_service.dart';

part 'statics_state.dart';

@injectable
class StaticsCubit extends Cubit<StaticsState> {
  StaticsCubit(this._service, this._leagueService)
      : super(const StaticsState());

  final IMatchEventService _service;
  final ILeagueService _leagueService;
  late final int refereeID;

  Future<void> onLoadInitialData(final int? refereeId) async {
    refereeID = refereeId ?? 0;
    onLoadRefereeLeagues();
  }

  Future<void> onLoadRefereeLeagues() async {
    emit(state.copyWith(screenState: RefereeStaticsScreenState.loadingLeagues));
    final leagues = await _leagueService.getRefereeLeagues(refereeID);
    if (leagues.isEmpty) {
      emit(state.copyWith(
          screenState: RefereeStaticsScreenState.emptyLeaguesList));
    } else {
      emit(state.copyWith(
          refereeLeagues: leagues,
          selectedLeague: leagues.first,
          screenState: RefereeStaticsScreenState.leaguesLoaded));
      _onLoadGlobalStatics(leagues.first);
    }
  }

  Future<void> onChangeLeague(final League? league) async {
    if (league == state.selectedLeague ||
        state.screenState == RefereeStaticsScreenState.loadingGlobalStatics) {
      return;
    }
    _onLoadGlobalStatics(league);
  }

  Future<void> _onLoadGlobalStatics(final League? league) async {
    emit(state.copyWith(
        screenState: RefereeStaticsScreenState.loadingGlobalStatics));
    final request =
        await _service.getGlobalStatics(refereeID, league?.leagueId ?? 0);
    request.fold(
        (l) => emit(state.copyWith(
            screenState: RefereeStaticsScreenState.globalStaticsLoaded)),
        (r) => emit(state.copyWith(
            screenState: RefereeStaticsScreenState.globalStaticsLoaded,
            selectedLeague: league,
            globalStatics: r)));
  }

  // Future<void> onLoadInitialData(
  //     int personId, int leagueId, int refereeId) async {
  //   emit(state.copyWith(screenState: BasicCubitScreenState.loading));
  //   final staticsRequest = await _service.getRefereeStatics(personId, leagueId);
  //   final categoryRequest =
  //       await _categoryService.getCategoriesByLeagueId2(leagueId);
  //   final tournamentRequest =
  //       await _tournamentService.getAllTournamentByLeagueId(leagueId);
  //   _tournamentList.addAll(tournamentRequest.getOrElse(() => []));
  //   final tournaments = <Tournament>[];
  //   final categories = <Category>[];
  //   for (final e in staticsRequest) {
  //     final list = _tournamentList
  //         .where((element) => element.tournamentId == e.tournamentId)
  //         .toList();
  //     final listC = categoryRequest
  //         .where((element) => element.categoryName == e.categoryName);
  //     tournaments.add(Tournament(
  //         tournamentName: e.tournamentName, tournamentId: e.tournamentId));
  //     categories.addAll(listC);
  //   }
  //   final events = await _service.getTournamentEventCount(refereeId, leagueId);
  //   emit(state.copyWith(
  //     screenState: BasicCubitScreenState.loaded,
  //     refereeStatics: staticsRequest,
  //     categories: categories,
  //     selectedCategory: categories.isEmpty ? Category.empty : categories.first,
  //     selectedTournament:
  //         tournaments.isEmpty ? Tournament.empty : tournaments.first,
  //     tournaments: tournaments,
  //   ));
  // }

  /*void onChangeCategory(Category category) {
    final list = _tournamentList.where(
        (element) => element.categoryId?.categoryId == category.categoryId);
    emit(
        state.copyWith(tournaments: list.toList(), selectedCategory: category));
  }

  double getTournamentStatics(RefereeStatics static) {
    double total = 0.0;
    for (final e in state.refereeStatics) {
      total = total + e.asignaciones;
    }

    return ((static.asignaciones * 100) / total);
  }

  double getEventStatics(CountEventTournament event) {
    double total = 0.0;
    for (final e in state.events) {
      total = total + e.matchEventC;
    }

    return ((event.matchEventC * 100) / total);
  }*/
}
