import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/models/common_pageable_response.dart';
import 'package:ligas_futbol_flutter/src/domain/player/dto/full_player_vs_dto.dart';

import '../../../../domain/player/service/i_player_service.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';
import '../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'search_player_state.dart';

@injectable
class SearchPlayerCubit extends Cubit<SearchPlayerState> {
  SearchPlayerCubit(this._searchPlayerService, this._requestService)
      : super(const SearchPlayerState());
  final IPlayerService _searchPlayerService;
  final IUserRequestsService _requestService;

  final List<FullPlayerVsDTO> _originalPlayerList = [];
  int page = 0;

  void initPage({required int teamId}) {
    emit(state.copyWith(currentTeamId: teamId));
    getSearchPlayers();
  }

  Future<void> getSearchPlayers({String? sName}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    //getSearchPlayers(teamId, preferenceposition);
    final response = await _searchPlayerService.getSearchPlayer(
      page: page,
      size: 15,
      teamId: state.currentTeamId,
      playerName: sName,
      preferenceposition: null,
    );
    response.fold((l) {
      print(">>> fold : $l");
      emit(state.copyWith(
        screenStatus: ScreenStatus.loaded,
        listPlayers: _originalPlayerList,
        noMatches: true,
      ));
    }, (r) {
      _originalPlayerList.addAll(r.content);
      emit(state.copyWith(
        screenStatus: ScreenStatus.loaded,
        noMatches: false,
        playerPageable: r,
        listPlayers: r.content,
      ));
    });
  }

  Future<void> onSendTeamToPlayerRequest(int playerId, int teamId) async {
    final response = await _requestService.saveRequestTeamToPlayer(UserRequests(
        requestId: 0,
        requestMadeById: teamId,
        requestStatus: '3',
        typeRequest: '1',
        requestMadeBy: '',
        requestToId: playerId));
    response.fold((l) {
      // print("error 1--------->");
      // print(jsonDecode(l.data ?? '')['comments']);
      // print("error 2--------->");
      // print(l.code);
      // print("error 3--------->");
      // print(l.errorMessage);
      emit(state.copyWith(
          screenStatus: ScreenStatus.error,
          msm: jsonDecode(l.data ?? '')['comments']));
    }, (r) {
      emit(state.copyWith(screenStatus: ScreenStatus.success));
    });
  }

  void goToFirstPage() {
    if (page == 0) {
      return;
    }
    page = 0;
    getSearchPlayers();
  }

  void onPreviousPage() {
    if (page <= 0) {
      return;
    }
    page--;
    getSearchPlayers();
  }

  void onNextPage() {
    if (page + 1 > state.playerPageable.totalPages) {
      return;
    }
    page++;
    getSearchPlayers();
  }

  void goToLastPage() {
    if (page == state.playerPageable.totalPages) {
      return;
    }
    page = state.playerPageable.totalPages - 1;
    getSearchPlayers();
  }

  void onFilterList(
    String input,
  ) async {
    if (input.trim().isNotEmpty) {
      final items = state.playerPageable.content.where((element) {
        return element.fullName!.toLowerCase().contains(input.toLowerCase());
      }).toList();

      if (items.isNotEmpty) {
        emit(state.copyWith(listPlayers: items, noMatches: false));
      } else {
        getSearchPlayers(sName: input.split(" ").join("_"));
      }
    }
  }
}
