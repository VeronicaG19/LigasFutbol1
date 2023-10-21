import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/leagues.dart';

import '../../../../core/enums.dart';
import '../../../../core/models/common_pageable_response.dart';
import '../../../../domain/category/category.dart';
import '../../../../domain/team/entity/team.dart';
import '../../../../domain/team/service/i_team_service.dart';

part 'search_team_state.dart';

@injectable
class SearchTeamCubit extends Cubit<SearchTeamState> {
  SearchTeamCubit(
      this._teamService, this._iLeagueService, this._categoryService)
      : super(const SearchTeamState());

  final ITeamService _teamService;
  final ILeagueService _iLeagueService;
  final ICategoryService _categoryService;
  final List<Team> _originalTeamList = [];
  int page = 0;

  Future<void> getTeams() async {
    Trace customTrace = FirebasePerformance.instance.newTrace('getTeams-trace');
    await customTrace.start();
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response =
        await _teamService.getAllTeams(page: page, size: 25, categoryId: 0);
    response.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      _originalTeamList.addAll(r.content);
      emit(state.copyWith(
        teamPageable: r,
      ));
      getLeagues();
    });
    await customTrace.stop();
  }

  Future<void> getLeagues() async {
    final reponse = await _iLeagueService.getAllLeagues();
    reponse.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
        leages: r,
        screenState: BasicCubitScreenState.loaded,
      ));
    });
  }

  void onNextPage() {
    if (page + 1 > state.teamPageable.totalPages) {
      return;
    }
    page++;
    getTeams();
  }

  void onPreviousPage() {
    if (page <= 0) {
      return;
    }
    page--;
    getTeams();
  }

  void goToLastPage() {
    if (page == state.teamPageable.totalPages) {
      return;
    }
    page = state.teamPageable.totalPages - 1;
    getTeams();
  }

  void goToFirstPage() {
    if (page == 0) {
      return;
    }
    page = 0;
    getTeams();
  }

  void onFilterList(String input) async {
    if (input.trim().length < 4) {
      final items = _originalTeamList
          .where((element) =>
              input.isEmpty ||
              element.teamNameValidated
                  .toLowerCase()
                  .contains(input.toLowerCase()))
          .toList();
      emit(state.copyWith(
          teamPageable: state.teamPageable.copyWith(content: items)));
    } else {
      //emit(state.copyWith(screenState: BasicCubitScreenState.loading));
      final response = await _teamService.getAllTeams(
          page: page,
          size: 25,
          categoryId: state.catSelect.categoryId ?? 0,
          requestPlayers: state.requestPlayers,
          teamName: input.split(" ").join("_"));
      response.fold(
          (l) => emit(state.copyWith(
              screenState: BasicCubitScreenState.error,
              errorMessage: l.errorMessage)), (r) {
        //_originalTeamList.addAll(r.content);

        emit(state.copyWith(
          screenState: BasicCubitScreenState.loaded,
          teamPageable: r,
        ));
      });
    }
  }

  Future<void> onChangeLeague(League leage) async {
    print('change lige');
    emit(state.copyWith(leageSlct: leage));
  }

  Future<void> getCategoriesByLeague(League league) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));

    final response =
        await _categoryService.getCategoriesByLeagueId(league.leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.loaded,
            categoriesList: const [])), (r) {
      emit(state.copyWith(
        screenState: BasicCubitScreenState.loaded,
        categoriesList: r,
        catSelect: Category.empty,
      ));
    });
  }

  Future<void> onChangeCategory(Category category) async {
    emit(state.copyWith(catSelect: category));
  }

  Future<void> onChangeRequestPlayer(bool requestPlayer) async {
    print(requestPlayer);
    emit(state.copyWith(
        requestPlayers: (requestPlayer == false) ? 'Y' : 'N',
        screenState: BasicCubitScreenState.loaded));
  }

  Future<void> onApplyFilters() async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response = await _teamService.getAllTeams(
        page: page,
        size: 25,
        categoryId: state.catSelect.categoryId ?? 0,
        requestPlayers: state.requestPlayers);
    response.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      _originalTeamList.addAll(r.content);

      emit(state.copyWith(
        screenState: BasicCubitScreenState.loaded,
        teamPageable: r,
      ));
    });
  }

  Future<void> onCleanFilters() async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response =
        await _teamService.getAllTeams(page: page, size: 25, categoryId: 0);
    response.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      _originalTeamList.addAll(r.content);
      emit(state.copyWith(
          teamPageable: r,
          catSelect: Category.empty,
          leageSlct: League.empty,
          requestPlayers: 'N'));
      getLeagues();
    });
  }
}
