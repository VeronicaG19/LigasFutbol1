import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums.dart';
import '../../../../core/models/common_pageable_response.dart';
import '../../../../domain/team/entity/team.dart';
import '../../../../domain/team/service/i_team_service.dart';

part 'search_team_state.dart';

@injectable
class SearchTeamCubit extends Cubit<SearchTeamState> {
  SearchTeamCubit(this._teamService) : super(const SearchTeamState());

  final ITeamService _teamService;
  final List<Team> _originalTeamList = [];
  int page = 0;

  Future<void> getTeams() async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response = await _teamService.getAllTeams(page: page, size: 12);
    response.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      _originalTeamList.addAll(r.content);
      emit(state.copyWith(
        teamPageable: r,
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

  void onFilterList(String input) {
    final items = _originalTeamList
        .where((element) =>
            input.isEmpty ||
            element.teamNameValidated
                .toLowerCase()
                .contains(input.toLowerCase()))
        .toList();
    emit(state.copyWith(
        teamPageable: state.teamPageable.copyWith(content: items)));
  }
}
