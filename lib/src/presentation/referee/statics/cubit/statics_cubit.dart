import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums.dart';
import '../../../../domain/category/category.dart';
import '../../../../domain/referee/entity/count_tournament_event.dart';
import '../../../../domain/referee/entity/referee_statics.dart';
import '../../../../domain/referee/service/i_referee_service.dart';
import '../../../../domain/tournament/entity/tournament.dart';
import '../../../../domain/tournament/service/i_tournament_service.dart';

part 'statics_state.dart';

@injectable
class StaticsCubit extends Cubit<StaticsState> {
  StaticsCubit(this._service, this._categoryService, this._tournamentService)
      : super(const StaticsState());

  final IRefereeService _service;
  final ICategoryService _categoryService;
  final ITournamentService _tournamentService;
  final List<Tournament> _tournamentList = [];

  Future<void> onLoadInitialData(
      int personId, int leagueId, int refereeId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final staticsRequest = await _service.getRefereeStatics(personId, leagueId);
    // final categoryRequest =
    //     await _categoryService.getCategoriesByLeagueId2(leagueId);
    // final tournamentRequest =
    //     await _tournamentService.getAllTournamentByLeagueId(leagueId);
    // _tournamentList.addAll(tournamentRequest.getOrElse(() => []));
    final tournaments = <Tournament>[];
    final categories = <Category>[];
    for (final e in staticsRequest) {
      // final list = _tournamentList
      //     .where((element) => element.tournamentId == e.tournamentId)
      //     .toList();
      // final listC = categoryRequest
      //     .where((element) => element.categoryName == e.categoryName);
      // tournaments.add(Tournament(
      //     tournamentName: e.tournamentName, tournamentId: e.tournamentId));
      // categories.addAll(listC);
    }
    // final events = await _service.getTournamentEventCount(refereeId, leagueId);
    emit(state.copyWith(
      screenState: BasicCubitScreenState.loaded,
      refereeStatics: staticsRequest,
      categories: categories,
      selectedCategory: categories.isEmpty ? Category.empty : categories.first,
      selectedTournament:
          tournaments.isEmpty ? Tournament.empty : tournaments.first,
      tournaments: tournaments,
    ));
  }

  void onChangeCategory(Category category) {
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
  }
}
