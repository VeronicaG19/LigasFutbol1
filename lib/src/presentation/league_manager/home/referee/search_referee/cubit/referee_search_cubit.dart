import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/exception/lf_app_failure.dart';
import '../../../../../../domain/referee/entity/referee.dart';
import '../../../../../../domain/referee/entity/referee_by_league_dto.dart';
import '../../../../../../domain/referee/entity/referee_detail_dto.dart';
import '../../../../../../domain/referee/referee_last_name.dart';
import '../../../../../../domain/referee/referee_name.dart';
import '../../../../../../domain/referee/referee_phone.dart';
import '../../../../../../domain/referee/refreree_email.dart';
import '../../../../../../domain/referee/service/i_referee_service.dart';
import '../../../../../../domain/user_requests/service/i_user_requests_service.dart';


part 'referee_search_state.dart';
@injectable
class RefereeSearchCubit extends Cubit<RefereeSearchState> {
  RefereeSearchCubit(this._requestsService, this._service) : super(const RefereeSearchState());
  final IRefereeService _service;
  final IUserRequestsService _requestsService;

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
            (r) =>
            emit(state.copyWith(screenStatus: ScreenStatus.success)));
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
