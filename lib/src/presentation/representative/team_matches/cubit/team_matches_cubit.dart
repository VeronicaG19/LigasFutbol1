import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/team/dto/matches_by_team/matches_by_team.dart';
import '../../../../domain/team/entity/team.dart';
import '../../../../domain/team/service/i_team_service.dart';

part 'team_matches_state.dart';

@injectable
class TeamMatchesCubit extends Cubit<TeamMatchesState> {
  TeamMatchesCubit(this._teamService)
      : super(const TeamMatchesState());

  final ITeamService _teamService;

  Future<void> getMatchesByTeam({ required int teamId}) async{
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _teamService.getMatchesByTeam(teamId);
    response.fold(
            (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Partidos ---> ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, matchesList: r));
    });
  }
}
