import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';
import '../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'representantive_requests_state.dart';

@injectable
class RepresentantiveRequestsCubit extends Cubit<RepresentantiveRequestsState> {
  RepresentantiveRequestsCubit(this._requestsService) : super(const RepresentantiveRequestsState());

  final IUserRequestsService _requestsService;
  final List<UserRequests> _teamToLeague = [];

  Future<void> loadRepresentativeRequests({required int teamId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));

    final received = await _requestsService.getRequestPlayerToTeam(teamId: teamId);
    final sent = await _requestsService.getRequestTeamToPlayer(teamId: teamId);
    final teamToL = await _requestsService.getRequestsTeamToLeague(teamId: teamId);
    _teamToLeague.addAll(teamToL);
    emit(
      state.copyWith(
          screenStatus: ScreenStatus.loaded,
          sentRequestsList: sent,
          receivedRequestsList: received,
          adminRequestList: _teamToLeague
          //teamToLRequestList: _teamToLeague,
      )
    );
  }

  Future<void> sendRequestStatus({required int requestId, required int teamId,
    required bool status}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _requestsService.updateUserRequest(requestId, status);
    response.fold(
            (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      loadRepresentativeRequests(teamId: teamId);
    });
  }

  Future<void> cancelUserRequest(
      {required int requestId, required int teamId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _requestsService.cancelUserRequest(requestId);
    response.fold(
            (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)),
            (r) {
          loadRepresentativeRequests(teamId: teamId);
        }
    );
  }
}
