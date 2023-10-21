import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/service/i_user_requests_service.dart';

import '../../../../core/validators/simple_text_validator.dart';
import '../../../../domain/leagues/leagues.dart';
import '../../../../domain/roles/service/i_rol_service.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';

part 'rquest_state.dart';

@injectable
class RquestCubit extends Cubit<RquestState> {
  RquestCubit(
      this._iUserRequestsService, this._iRolService, this._leagueService)
      : super(const RquestState());
  final IUserRequestsService _iUserRequestsService;
  final IRolService _iRolService;
  final ILeagueService _leagueService;

  Future<void> getPendingRequest() async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _iUserRequestsService.getRequestLeagueToAdmin();
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error, errorMessage: l.errorMessage)),
        (r) => emit(
            state.copyWith(screenStatus: ScreenStatus.loaded, request: r)));
  }

  Future<void> getPendingRequestField() async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _iUserRequestsService.getRequestFieldToAdmin();
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error, errorMessage: l.errorMessage)),
        (r) => emit(
            state.copyWith(screenStatus: ScreenStatus.loaded, request: r)));
  }

  Future<void> getLeagueCancelRequests() async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final leagues = await _iUserRequestsService.getDeleteLeaguesRequest();
    emit(state.copyWith(screenStatus: ScreenStatus.loaded, request: leagues));
  }

  Future<void> onAcceptRequest(int requestId, bool status, int personId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));

    final response =
        await _iUserRequestsService.updateAdminUserRequest(requestId, status);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error, errorMessage: l.errorMessage)),
        (r) => {
              emit(state.copyWith(
                screenStatus: ScreenStatus.loaded,
              )),
              updateRole(Rolesnm.LEAGUE_MANAGER, personId)
              //getPendingRequest()
            });
  }

  Future<void> onAcceptRequestField(int requestId, bool status) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));

    final response =
        await _iUserRequestsService.updateAdminUserRequest(requestId, status);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error, errorMessage: l.errorMessage)),
        (r) => {
              emit(state.copyWith(
                screenStatus: ScreenStatus.loaded,
              )),
              getPendingRequestField()
            });
  }

  Future<void> updateRole(Rolesnm role, int personId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response =
        await _iRolService.createUserRolAndUpdateByNames(personId, role.name);

    response.fold(
        (l) => {
              emit(state.copyWith(
                  screenStatus: ScreenStatus.error,
                  errorMessage: l.errorMessage))
            },
        (r) => {
              emit(state.copyWith(
                screenStatus: ScreenStatus.loaded,
              )),
              getPendingRequest()
            });
  }

  void onDescriptionChanged(String value) {
    final description = SimpleTextValidator.dirty(value);
    emit(state.copyWith(
        description: description, formzStatus: Formz.validate([description])));
  }

  void onDeleteLeague(UserRequests request) async {
    final leagueId = request.requestToId;
    if (leagueId == null) return;
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    await _iUserRequestsService.patchUserRequest(request.copyWith(
      requestStatus: '4',
      typeRequest: '16',
    ));
    final result = await _leagueService.deleteLeague(leagueId, true);
    result.fold(
        (l) => emit(state.copyWith(
            formzStatus: FormzStatus.submissionFailure,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
      getLeagueCancelRequests();
    });
  }

  void onRejectCancellationOnLeague(UserRequests request) async {
    final valid = Formz.validate([state.description]);
    if (!valid.isValidated) {
      emit(state.copyWith(
          description: SimpleTextValidator.dirty(state.description.value)));
      return;
    }
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    final response = await _iUserRequestsService.patchUserRequest(
        request.copyWith(
            comments: state.description.value,
            requestStatus: '5',
            typeRequest: '16'));
    response.fold(
        (l) => emit(state.copyWith(
            formzStatus: FormzStatus.submissionFailure,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
      getLeagueCancelRequests();
    });
  }
}
