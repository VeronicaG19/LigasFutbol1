import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team/service/i_team_service.dart';
import '../../../../domain/team/entity/team.dart';

part 'representative_teams_state.dart';

@injectable
class RepresentativeTeamsCubit extends Cubit<RepresentativeTeamsState> {
  RepresentativeTeamsCubit(this._teamService) : super(const RepresentativeTeamsState());

  final ITeamService _teamService;

  Future<void> getRepresentativeTeams({required int personId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _teamService.getTeamsFindByRepresentant(personId);
    response.fold(
            (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Equipos---> ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, teamList: r));
    });
  }
}
