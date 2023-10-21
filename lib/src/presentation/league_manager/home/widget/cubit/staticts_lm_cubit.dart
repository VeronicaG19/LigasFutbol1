import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/category/category.dart';
import 'package:ligas_futbol_flutter/src/domain/team/service/i_team_service.dart';

import '../../../../../core/enums.dart';
import '../../../../../core/exception/lf_app_failure.dart';
import '../../../../../domain/countResponse/entity/register_count_interface.dart';
import '../../../../../domain/tournament/service/i_tournament_service.dart';
import '../../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'staticts_lm_state.dart';


@injectable
class StatictsLmCubit extends Cubit<StatictsLmState> {
  StatictsLmCubit(this._service, this._serviceCategory, this._serviceTeam,this._requestsService) : super(StatictsLmState());
  final ITournamentService _service;
  final ICategoryService _serviceCategory;
  final ITeamService _serviceTeam;
  final IUserRequestsService _requestsService;


  Future<void> loadStaticts({required int leagueId}) async {
    emit(state.copyWith(screenStatus: ScreenStatusA.loading));
    final response = await _service.getCountByLeagueId(leagueId);
    response.fold(
            (l) => emit(state.copyWith(
            screenStatus: ScreenStatusA.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r}");
      emit(state.copyWith(screenStatus: ScreenStatusA.loaded, detailTournament: r));
      loadcategories(leagueId: leagueId);
      loadTeams(leagueId: leagueId);
    });
  }

  Future<void> loadcategories({required int leagueId}) async {
    emit(state.copyWith(screenStatus: ScreenStatusA.loading));
    final response = await _serviceCategory.getCountByLeagueId(leagueId);
    response.fold(
            (l) =>
            emit(state.copyWith(
                screenStatus: ScreenStatusA.error,
                errorMessage: l.errorMessage)), (r) {
      print("Datos ${r}");
      emit(
          state.copyWith(screenStatus: ScreenStatusA.loaded, detailCategory: r));

    });
  }

    Future<void> loadTeams({required int leagueId}) async {
      emit(state.copyWith(screenStatus: ScreenStatusA.loading));
      final response = await _serviceTeam.getCountByLeagueId(leagueId);
      response.fold(
              (l) => emit(state.copyWith(
              screenStatus: ScreenStatusA.error,
              errorMessage: l.errorMessage)), (r) {
        print("Datos ${r}");
        emit(state.copyWith(screenStatus: ScreenStatusA.loaded, detailTeam: r));
      });
    }

  Future<void> onSendRequest(int refereeId, int leagueId) async {
    emit(state.copyWith(screenStatus: ScreenStatusA.sending));
    final request =
    await _requestsService.sendLeagueToRefereeRequest(refereeId, leagueId);
    request.fold(
            (l) => emit(state.copyWith(
                screenStatus: ScreenStatusA.error,
            errorMessage: _getErrorMessage(l))),
            (r) =>
            emit(state.copyWith(screenStatus: ScreenStatusA.success)));
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