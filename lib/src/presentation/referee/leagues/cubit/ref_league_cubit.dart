import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/entity/user_requests.dart';

import '../../../../core/enums.dart';
import '../../../../core/exception/lf_app_failure.dart';
import '../../../../domain/leagues/leagues.dart';
import '../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'ref_league_state.dart';

@injectable
class RefLeagueCubit extends Cubit<RefLeagueState> {
  RefLeagueCubit(this._leagueService, this._requestsService)
      : super(const RefLeagueState());

  final ILeagueService _leagueService;
  final List<League> _oLeague = [];
  final IUserRequestsService _requestsService;

  Future<void> onLoadInitialData() async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final request = await _leagueService.getAllLeagues();
    request.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      _oLeague.addAll(r);
      emit(state.copyWith(
          leagueList: r, screenState: BasicCubitScreenState.loaded));
    });
  }

  Future<void> onSendRequest(int refereeId, int leagueId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.sending));
    final request =
        await _requestsService.sendRefereeRequestToLeague(refereeId, leagueId);
    request.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: _getErrorMessage(l))),
        (r) =>
            emit(state.copyWith(screenState: BasicCubitScreenState.success)));
  }

  String _getErrorMessage(LFAppFailure failure) {
    final data = jsonDecode(failure.data ?? '');
    if (data['requestId'] == -1) {
      return 'Ya has enviado solicitud a esta liga';
    } else {
      return 'No se ha podido enviar la solicitud';
    }
  }

  void onFilterList(String input) {
    final requests = _leagueService.filterRequestList(input, _oLeague);
    emit(state.copyWith(leagueList: requests));
  }
}
