import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/domain/team/service/i_team_service.dart';

part 'team_by_state.dart';

@injectable
class TeamByPlayersCubit extends Cubit<TeamByPlayerState> {
  TeamByPlayersCubit(this._teamService) : super(const TeamByPlayerState());

  final ITeamService _teamService;

  Future<void> getsAllTeamsPlayer({required int partyId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _teamService.getsAllTeamsPlayer(partyId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, teamList: r));
    });
  }
}
