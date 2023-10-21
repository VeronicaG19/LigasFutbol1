import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';

import '../../../../domain/agenda/agenda.dart';
import '../../../../domain/agenda/entity/qra_event.dart';
import '../../../../domain/user_requests/dto/request_match_to_referee_dto.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';
import '../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'referee_request_state.dart';

@injectable
class RefereeRequestCubit extends Cubit<RefereeRequestState> {
  RefereeRequestCubit(this._service, this._agendaService)
      : super(const RefereeRequestState());

  final IUserRequestsService _service;
  final IAgendaService _agendaService;

  Future<void> loadUserRequests({
    required int personId,
    required int refereeId,
  }) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));
    final sentRequests =
        await _service.getRequestRefereeToLeague(refereeId: personId);
    final receivedRequests =
        await _service.getRequestLeagueToReferee(refereeId: personId);
    final requestMatch = await _service.getRequestMatchToReferee(refereeId);
    emit(
      state.copyWith(
          screenStatus: BasicCubitScreenState.loaded,
          sentRequestsList: sentRequests,
          receivedRequestsList: receivedRequests,
          requestMatchRefereeList: requestMatch),
    );
  }

  Future<void> cancelUserRequest({
    required int requestId,
    required int personId,
    required int refereeId,
  }) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));
    final response = await _service.cancelUserRequest(requestId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      loadUserRequests(personId: personId, refereeId: refereeId);
    });
  }

  Future<void> onUpdateRequestStatus({
    required int requestId,
    required int personId,
    required bool status,
    required int refereeId,
  }) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));
    final response =
        await _service.sendRefereeResponseRequest(requestId, status);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      loadUserRequests(personId: personId, refereeId: refereeId);
    });
  }

  Future<void> onSendResponseRequest({
    required int requestId,
    required bool accepted,
    required int personId,
    required int refereeId,
  }) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));
    final response =
        await _service.sendRefereeResponseRequest(requestId, accepted);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      loadUserRequests(personId: personId, refereeId: refereeId);
    });
  }

  Future<void> onAcceptMatchRequest({
    required RequestMatchToRefereeDTO request,
    required bool accepted,
    required int personId,
    required int refereeId,
  }) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));
    final dateFormat = DateFormat('DD-MM-yyyy HH:mm');
    final event = QraEvent(
      activeId: request.activeId!,
      duration: request.durationEvent!,
      entytyId: request.refereeID!,
      timePeriod: 1,
      status: 1,
      assignmentStatus: 'SEND',
      currency: Currency.MXN,
      information: request.teamMatch!,
      pediod: TimeType.MATCH,
      subject: 'Partido',
      endDate: dateFormat.parse(request.endDate!),
      endHour: dateFormat.parse(request.endDate!),
      startDate: dateFormat.parse(request.startDate!),
      startHour: dateFormat.parse(request.startDate!),
      price: 0,
      startHourString: '',
      endHourString: '',
    );
    final eventRequest = await _agendaService.createQraEvents(event);
    eventRequest.fold(
        (l) => emit(state.copyWith(
            screenStatus: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) async {
      final response = await _service.sendRefereeResponseRequest(
          request.requestId!, accepted);

      response.fold(
          (l) => emit(state.copyWith(
              screenStatus: BasicCubitScreenState.error,
              errorMessage: l.errorMessage)), (r) {
        loadUserRequests(personId: personId, refereeId: refereeId);
      });
    });
  }
}
