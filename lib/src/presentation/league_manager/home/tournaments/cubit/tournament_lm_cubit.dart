import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../../domain/tournament/entity/tournament.dart';
import '../../../../../domain/tournament/service/i_tournament_service.dart';

part 'tournament_lm_state.dart';

@injectable
class TournamentLmCubit extends Cubit<TournamentLmState> {
  TournamentLmCubit(this._service) : super(TournamentLmState());
  final ITournamentService _service;

  Future<void> loadTournament({required int leagueId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.getAllTournamentByLeagueId(leagueId);
    response.fold(
            (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, tournamentList: r));
    });
  }

}