import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_event.dart';

import '../../../../core/enums.dart';
import '../../../../domain/agenda/agenda.dart';
import '../../../../domain/user_requests/entity/field_owner_request.dart';
import '../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'fo_request_state.dart';

@injectable
class FoRequestCubit extends Cubit<FoRequestState> {
  FoRequestCubit(this._service, this._agendaService)
      : super(const FoRequestState());

  final IUserRequestsService _service;
  final IAgendaService _agendaService;

  Future<void> onLoadInitialData(final int ownerId) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));
    final requests = await _service.getFieldOwnerRequests(ownerId);
    emit(
      state.copyWith(
          screenStatus: BasicCubitScreenState.loaded, requestsList: requests),
    );
  }

  Future<void> onCancelRequest(final int requestId, final int ownerId) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));
    final response = await _service.cancelUserRequest(requestId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      onLoadInitialData(ownerId);
    });
  }

  Future<void> onAcceptRequest(
      final FieldOwnerRequest request, final int ownerId) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));

    final dateFormat = DateFormat('DD-MM-yyyy HH:mm');

    final event = QraEvent(
      activeId: request.activeId,
      duration: request.eventDuration,
      entytyId: request.fieldId,
      timePeriod: 1,
      status: 1,
      assignmentStatus: 'SEND',
      currency: Currency.values
          .firstWhere((element) => element.name == request.currency),
      information: request.teamMatch,
      pediod: TimeType.MONTHLY,
      subject: 'Partido',
      endDate: dateFormat.parse(request.endDate!),
      endHour: dateFormat.parse(request.endDate!),
      startDate: dateFormat.parse(request.startDate!),
      startHour: dateFormat.parse(request.startDate!),
      price: request.price,
      startHourString: '',
      endHourString: '',
    );
    final eventRequest = await _agendaService.createQraEvents(event);
    eventRequest.fold(
        (l) => emit(state.copyWith(
            screenStatus: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) async {
      final response =
          await _service.acceptFieldOwnerRequest(request.requestId);
      response.fold(
          (l) => emit(state.copyWith(
              screenStatus: BasicCubitScreenState.error,
              errorMessage: l.errorMessage)), (r) {
        emit(state.copyWith(screenStatus: BasicCubitScreenState.success));
        onLoadInitialData(ownerId);
      });
    });
  }
}
