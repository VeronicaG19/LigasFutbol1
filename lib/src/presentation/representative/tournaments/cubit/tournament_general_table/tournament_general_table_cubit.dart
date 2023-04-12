import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/service/i_team_tournament_service.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';

part 'tournament_general_table_state.dart';

@injectable
class TournamentGeneralTableCubit extends Cubit<TournamentGeneralTableState> {
  TournamentGeneralTableCubit(this._teamTournamentService)
      : super(const TournamentGeneralTableState());
  final ITeamTournamentService _teamTournamentService;

  Future<void> getGeneralTable({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));

    final response =
        await _teamTournamentService.getGeneralTableByTournament(tournamentId);

    return response.fold(
      (l) => emit(state.copyWith(
          screenStatus: ScreenStatus.error, errorMessage: l.errorMessage)),
      (r) {
        print('Tabla general ---> ${r.length}');
        emit(
            state.copyWith(screenStatus: ScreenStatus.loaded, generalTable: r));
      },
    );
  }
}
