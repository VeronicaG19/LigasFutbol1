import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/service/i_matches_service.dart';

import '../../../../../domain/matches/interface/matches_by_tournament_interface.dart';

part 'tournament_role_playing_state.dart';

@injectable
class TournamentRolePlayingCubit extends Cubit<TournamentRolePlayingState> {
  TournamentRolePlayingCubit(
    this._matchService,
  ) : super(const TournamentRolePlayingState());

  final IMatchesService _matchService;

  Future<void> getMatchDetailByTournamnet({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response =
        await _matchService.getMatchesByTournament(tournamentId);
    response.fold(
      (l) => emit(
        state.copyWith(
          screenStatus: ScreenStatus.error,
          errorMessage: l.errorMessage,
        ),
      ),
      (r) {
        print("Rol de juego ${r.length}");
        emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          matchmakingList: r,
        ));
      },
    );
  }
}
