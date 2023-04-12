import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/service/i_tournament_service.dart';
import '../../../../../domain/lookupvalue/entity/lookupvalue.dart';
import '../../../../../domain/lookupvalue/service/i_lookupvalue_service.dart';
import '../../../../../domain/tournament/dto/tournament_by_team/tournament_by_team_dto.dart';

part 'team_tournaments_state.dart';

@injectable
class TeamTournamentsCubit extends Cubit<TeamTournamentsState> {
  TeamTournamentsCubit(this._service, this._lookUpValueService)
      : super(const TeamTournamentsState());

  final ITournamentService _service;
  final ILookUpValueService _lookUpValueService;

  Future<void> getTeamTournaments({required int teamId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.getTeamTournamentsByTeamId(teamId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Torneos del equipo---> ${r.length}");
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded, tournamentsList: r));
      //getTypeFutbol();
    });
  }

  Future<void> getTypeFutbol() async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response =
    await _lookUpValueService.getLookUpValueByTypeLM("FOOTBALL_TYPE");
    response.fold(
            (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          footballTypeList: r,
      ));
      print("NAME ---> ${state.footballType.lookupName}");
    });
  }

}
