import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/endpoints.dart';
import 'package:meta/meta.dart';

import '../../../../domain/player/dto/search_player_dto.dart';
import '../../../../domain/player/service/i_player_service.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';
import '../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'search_player_state.dart';
@injectable
class SearchPlayerCubit extends Cubit<SearchPlayerState> {
  SearchPlayerCubit(
      this._searchPlayerService, this._requestService
      ) : super(const SearchPlayerState());
  final IPlayerService _searchPlayerService;
  final IUserRequestsService _requestService;
  Future<void> getSearchPlayers (int teamId, int preferenceposition) async{
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    //getSearchPlayers(teamId, preferenceposition);
    final response = await _searchPlayerService.getSearchPlayer(teamId,preferenceposition);
    response.fold(
            (l) => {
              emit(state.copyWith(
                screenStatus: ScreenStatus.loaded
              ))
            },(r){
              emit(state.copyWith(screenStatus: ScreenStatus.loaded,searchPlayer: r));

    });
  }


  Future<void> onSendTeamToPlayerRequest(int playerId, int teamId) async{
    final response = await _requestService.saveRequestTeamToPlayer(UserRequests(
        requestId: 0,
        requestMadeById: teamId,
        requestStatus: '3',
        typeRequest: '1',
        requestMadeBy: '',
        requestToId: playerId
    ));
    response.fold(
            (l) => emit(state.copyWith(
              screenStatus: ScreenStatus.error
            )),
            (r) {
              emit(state.copyWith(
                screenStatus: ScreenStatus.success
              ));
            });
}
}
