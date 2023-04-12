import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/service/i_user_requests_service.dart';

import '../../../domain/user_requests/entity/user_requests.dart';

part 'user_requests_state.dart';

@injectable
class UserRequestsCubit extends Cubit<UserRequestsState> {
  UserRequestsCubit(this._service) : super(const UserRequestsState());
  final IUserRequestsService _service;

  Future<void> loadUserRequests({required int personId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final sentRequests = await _service.getRequestPlayerToTeam(partyId: personId);
    final receivedRequests =
        await _service.getRequestTeamToPlayer(partyId: personId);
    emit(
      state.copyWith(
          screenStatus: ScreenStatus.loaded,
          sentRequestsList: sentRequests,
          receivedRequestsList: receivedRequests),
    );
  }

  Future<void> cancelUserRequest(
      {required int requestId, required int personId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.cancelUserRequest(requestId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      loadUserRequests(personId: personId);
    });
  }

  Future<void> onUpdateRequestStatus(
      {required int requestId,
      required int personId,
      required bool status}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.updateUserRequest(requestId, status);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      loadUserRequests(personId: personId);
    });
  }
}
