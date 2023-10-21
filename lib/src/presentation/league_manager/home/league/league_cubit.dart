import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/entity/league.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/service/i_league_service.dart';

import '../../../../core/validators/simple_text_validator.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';
import '../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'league_state.dart';

@injectable
class LeagueByLeagueManagerCubit extends Cubit<LeagueByLeagueManagerState> {
  LeagueByLeagueManagerCubit(this._service, this._requestsService)
      : super(const LeagueByLeagueManagerState());
  final ILeagueService _service;
  final IUserRequestsService _requestsService;

  Future<void> deleteLeague({required League league}) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response = await _service.deleteLeague(league.leagueId, false);
    response.fold(
        (l) => {
              emit(state.copyWith(
                  screenState: BasicCubitScreenState.error,
                  errorMessage: l.errorMessage))
            }, (r) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.success, league: league));
    });
  }

  void onDescriptionChanged(String value) {
    final description = SimpleTextValidator.dirty(value);
    emit(state.copyWith(
        description: description, formzStatus: Formz.validate([description])));
  }

  void onSendRequest(final int? personId, final int? leagueId) async {
    final valid = Formz.validate([state.description]);
    if (!valid.isValidated) {
      emit(state.copyWith(
          description: SimpleTextValidator.dirty(state.description.value)));
      return;
    }
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    final leagueRequest = UserRequests.empty.copyWith(
      content: state.description.value,
      requestStatus: '3',
      typeRequest: '16',
      requestToId: leagueId,
      requestMadeById: personId,
    );
    final response = await _requestsService.postUserRequest(leagueRequest);
    response.fold(
        (l) => emit(state.copyWith(
            formzStatus: FormzStatus.submissionFailure,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
    });
  }
}
