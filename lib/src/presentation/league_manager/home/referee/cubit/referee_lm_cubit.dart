import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/referee/service/i_referee_service.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../core/exception/lf_app_failure.dart';
import '../../../../../domain/referee/dto/create_referee_dto.dart';
import '../../../../../domain/referee/entity/rating_referee_dto.dart';
import '../../../../../domain/referee/entity/referee.dart';
import '../../../../../domain/referee/entity/referee_by_league_dto.dart';
import '../../../../../domain/referee/entity/referee_detail_dto.dart';
import '../../../../../domain/referee/referee_last_name.dart';
import '../../../../../domain/referee/referee_name.dart';
import '../../../../../domain/referee/referee_phone.dart';
import '../../../../../domain/referee/refreree_email.dart';
import '../../../../../domain/sign_up/models.dart';
import '../../../../../domain/user_requests/service/i_user_requests_service.dart';
import '../../../../sign_up/bloc/sign_up_bloc.dart';

part 'referee_lm_state.dart';

@injectable
class RefereeLmCubit extends Cubit<RefereeLmState> {
  RefereeLmCubit(this._service, this._repository, this._requestsService)
      : super(RefereeLmState());
  final IRefereeService _service;
  final AuthenticationRepository _repository;
  final IUserRequestsService _requestsService;

  Future<void> loadReferee({required int leagueId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.getRefereeByLeague1(leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, refereetList: r));
    });
  }

  Future<void> detailReferee({required int refereeId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.getRefereeDetail(refereeId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r}");
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded, refereeDetailDTO: r));
    });
  }

  Future<void> ratingReferee({required int refereeId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.getRefereeRating(refereeId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r}");
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded, ratingRefereeDTO: r));
    });
  }

  void onRefereeNameChange(String value) {
    final refereeName = RefereeName.dirty(value);
    emit(state.copyWith(
        refereeName: refereeName,
        status: Formz.validate([refereeName, state.refereeName])));
  }

  void onRefereeLastNameChange(String value) {
    final refereeLastName = RefereeLastName.dirty(value);
    emit(state.copyWith(
        refereeLastName: refereeLastName,
        status: Formz.validate([refereeLastName, state.refereeLastName])));
  }

  void onRefereeEmailChange(String value) {
    final refereeEmail = RefereeEmail.dirty(value);
    emit(state.copyWith(
        refereeEmail: refereeEmail,
        status: Formz.validate([refereeEmail, state.refereeEmail])));
  }

  void onRefereePhone(String value) {
    final refereePhone = RefereePhone.dirty(value);
    emit(state.copyWith(
        refereePhone: refereePhone,
        status: Formz.validate([refereePhone, state.refereePhone])));
  }

  void onVerificationSenderChanged(String value) {
    final verificationSender = VerificationSender.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          verificationSender,
          state.refereeLastName,
          state.refereeName,
        ]),
        verificationSender: verificationSender));
  }

  Future<void> createReferee({required int? leagueId}) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final user = User(
        userName: state.verificationSender.value,
        password: 'Welcome1',
        person: Person.buildPerson(
            firstName: state.refereeName.value,
            lastName: state.refereeLastName.value,
            areaCode: 'LF',
            email: state.getVerificationType() == VerificationType.email
                ? state.verificationSender.value
                : null,
            phone: state.getVerificationType() == VerificationType.phone
                ? state.verificationSender.value
                : null),
        applicationRol: ApplicationRol.referee);

    final signUpResponse = await _repository.signUp(user);
    signUpResponse.fold(
        (l) => emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: l.message,
            screenStatus: ScreenStatus.error)), (r) async {
      CreateRefereeDTO referee = CreateRefereeDTO(
          refereeAddress: '',
          refereeLatitude: '',
          refereeLength: '',
          partyId: r.person.personId,
          leagueId: leagueId,
          refereeCategory: 1,
          refereeType: 1);
      final response = await _service.createReferee(referee, user);
      response.fold(
          (l) => emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              errorMessage: l.errorMessage,
              screenStatus: ScreenStatus.error)), (r) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        loadReferee(leagueId: leagueId!);
      });
    });
  }

  Future<void> loadRefereeSearch({required int leagueId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.getSearchReferee1(leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, refereetList: r));
    });
  }

  Future<void> onSendRequest(int refereeId, int leagueId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.sending));
    final request =
        await _requestsService.sendLeagueToRefereeRequest(refereeId, leagueId);
    request.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: _getErrorMessage(l))),
        (r) => emit(state.copyWith(screenStatus: ScreenStatus.success)));
  }

  String _getErrorMessage(LFAppFailure failure) {
    final data = jsonDecode(failure.data ?? '');
    if (data['requestId'] == -1) {
      return 'Ya has enviado solicitud a este arbitro';
    } else {
      return 'No se ha podido enviar la solicitud';
    }
  }
}
