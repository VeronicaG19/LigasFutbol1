import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/entity/user_requests.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/service/i_user_requests_service.dart';

part 'tournaments_invitations_state.dart';

@injectable
class TournamentsInvitationsCubit extends Cubit<TournamentsInvitationsState> {
  TournamentsInvitationsCubit(
    this._userRequestsService,
  ) : super(const TournamentsInvitationsState());

  final IUserRequestsService _userRequestsService;

  final List<UserRequests> _teamToTournament = [];
  Future<void> getAllTournamentsInvitations({required int teamId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    //final response = await _userRequestsService.getAllTournamentsInvitations(teamId);
    final teamToTournamentR = await _userRequestsService.getRequestTeamToTournament(teamId: teamId!);
    _teamToTournament.addAll(teamToTournamentR);
    emit(state.copyWith(
      screenStatus: ScreenStatus.loaded,
      invitationsList: _teamToTournament,
    ));
  }

  Future<void> sendResponseToTournament({
    required requestId,
    required accepted,
  }) async {
    emit(state.copyWith(screenStatus: ScreenStatus.sendingResponse));

    final response = await _userRequestsService.sendResponseToTournament(
        requestId, accepted);

    response.fold(
      (l) => emit(state.copyWith(screenStatus: ScreenStatus.responseError)),
      (r) {
        print("Respuesta ---> $r");
        emit(state.copyWith(screenStatus: ScreenStatus.responseSended));
      },
    );
  }

  Future<void> cancelUserRequest(
      {required int requestId, required int teamId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _userRequestsService.cancelUserRequest(requestId);
    response.fold(
            (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), 
            (r) {
              emit(state.copyWith(screenStatus: ScreenStatus.responseSended));
              getAllTournamentsInvitations(teamId: teamId);
            }
    );
  }
}

