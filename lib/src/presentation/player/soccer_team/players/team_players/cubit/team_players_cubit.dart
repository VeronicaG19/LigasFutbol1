import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/entity/team_player.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/service/i_team_player_service.dart';

import '../../../../../../domain/player/dto/validate_request_dto.dart';
import '../../../../../../domain/player/service/i_player_service.dart';
import '../../../../../../domain/user_requests/entity/user_requests.dart';
import '../../../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'team_players_state.dart';

@injectable
class TeamPlayersCubit extends Cubit<TeamPlayerState> {
  TeamPlayersCubit(
      this._teamPlayerService, this._requestService, this._playerService)
      : super(const TeamPlayerState());

  final ITeamPlayerService _teamPlayerService;
  final IUserRequestsService _requestService;
  final IPlayerService _playerService;
  Future<void> getTeamPlayer(int partyId, int teamId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    getValidatedRequest(partyId, teamId);
    final response = await _teamPlayerService.getTeamPlayer(partyId, teamId);
    response.fold(
        (l) => {
              emit(state.copyWith(
                  screenStatus: ScreenStatus.loaded,
                  errorMessage: l.errorMessage)),
            }, (r) {
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, teamPlayer: r));
    });
  }

  Future<void> getValidatedRequest(int partyId, int teamId) async {
    final response = await _playerService.getvalidatedRequest(partyId, teamId);
    response.fold(
        (l) => {
              emit(state.copyWith(
                  screenStatus: ScreenStatus.loaded,
                  errorMessage: l.errorMessage)),
            }, (r) {
      print(r);
      emit(state.copyWith(validationrequet: r));
    });
  }

  Future<void> onSendPlayerToTeamRequest(int personId, int teamId) async {
    Trace customTrace = FirebasePerformance.instance
        .newTrace('onSendPlayerToTeamRequest-trace');
    await customTrace.start();
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final player = await _playerService.getDataPlayerByPartyId(personId);
    print(player);
    final playerId = player.fold((l) => 0, (r) => r.playerid ?? 0);
    print(playerId);
    if (playerId == 0) {
      emit(state.copyWith(
          errorMessage: 'No se pudo enviar la solicitud',
          screenStatus: ScreenStatus.error));
      return;
    }
    final response = await _requestService.saveUserRequest(UserRequests(
        requestId: 0,
        requestMadeById: playerId,
        requestStatus: '3',
        typeRequest: '2',
        requestMadeBy: '',
        requestToId: teamId));
    response.fold(
        (l) => emit(state.copyWith(
            errorMessage: 'No se pudo enviar la solicitud',
            screenStatus: ScreenStatus.error)), (r) {
      getValidatedRequest(personId, teamId);
      emit(state.copyWith(screenStatus: ScreenStatus.success));
    });

    await customTrace.stop();
  }
}
