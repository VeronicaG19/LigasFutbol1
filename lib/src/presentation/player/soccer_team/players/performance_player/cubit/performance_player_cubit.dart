import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/performance_by_tournament/performance_by_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/tournament_by_player/tournament_by_player.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/service/i_tournament_service.dart';

part 'performance_player_state.dart';

@injectable
class PerformancePlayerCubit extends Cubit<PerformancePlayerState> {
  PerformancePlayerCubit(this._tournamentService)
      : super(const PerformancePlayerState());

  final ITournamentService _tournamentService;

  Future<void> getTournamentByPlayer(int partyId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _tournamentService.getTournamentByPlayer(partyId);

    response.fold(
        (l) => {
              emit(state.copyWith(
                  screenStatus: ScreenStatus.error,
                  errorMessage: l.errorMessage)),
              print("Error ${l.errorMessage}")
            }, (r) {
      print("Datos ${r.length}");
      emit(
          state.copyWith(screenStatus: ScreenStatus.loaded, tournamentList: r));
    });
  }

  Future<void> getStaticsByTournament(int partyId, int tournamentId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response =
        await _tournamentService.getPerformanceByPlayer(partyId, tournamentId);

    response.fold(
        (l) => {
              emit(state.copyWith(
                  screenStatus: ScreenStatus.error,
                  errorMessage: l.errorMessage)),
              print("Error ${l.errorMessage}")
            }, (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, staticsList: r));
    });
  }
}
