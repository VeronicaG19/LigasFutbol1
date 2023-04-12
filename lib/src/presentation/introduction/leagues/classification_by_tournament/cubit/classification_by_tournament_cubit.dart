import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/category/category.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/service/i_tournament_service.dart';

part 'classification_by_tournament_state.dart';

@injectable
class ClassificationByTournamentCubit
    extends Cubit<ClassificationByTournamentState> {
  ClassificationByTournamentCubit(this._tournamentService)
      : super(const ClassificationByTournamentState());

  final ITournamentService _tournamentService;
  Future<void> getFindByNameAndCategory(
      {required Category category, required Tournament tournament}) async {
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading,
    ));
    print("Torneo-------->$tournament");
    print("Categoria-------->$category");
    final response = await _tournamentService.getFindByNameAndCategory(
        category.categoryId!, tournament.tournamentName!);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      getScoringTournament(tournamentId: r.tournamentId!);
    });
  }

  Future<void> getScoringTournament({required int tournamentId}) async {
    print("Valor del torneo---->$tournamentId");

    final response =
        await _tournamentService.getScoringTournamentId(tournamentId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded, scoringTournament: r));
    });
  }
}
