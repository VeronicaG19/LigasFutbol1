import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/category/category.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/service/i_tournament_service.dart';

import '../../../../../domain/scoring_system/entity/scoring_system.dart';
import '../../../../../domain/scoring_system/service/i_scoring_system_service.dart';
import '../../../../../domain/team_tournament/service/i_team_tournament_service.dart';

part 'classification_by_tournament_state.dart';

@injectable
class ClassificationByTournamentCubit
    extends Cubit<ClassificationByTournamentState> {
  ClassificationByTournamentCubit(this._tournamentService,
      this._scoringSystemService, this._iTeamTournamentService)
      : super(const ClassificationByTournamentState());

  final ITournamentService _tournamentService;
  final IScoringSystemService _scoringSystemService;
  final ITeamTournamentService _iTeamTournamentService;

  Future<void> getFindByNameAndCategory(
      {required Category category, required Tournament tournament}) async {
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading,
    ));
    final response = await _tournamentService.getFindByNameAndCategory(
        category.categoryId!, tournament.tournamentName!,
        requiresAuthToken: false);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      getScoringTournament(tournamentId: r.tournamentId!);
    });
  }

  Future<void> getScoringTournament({required int tournamentId}) async {
    final scoringSystemResponse = await _scoringSystemService
        .getScoringSystemByTournament(tournamentId, requiresAuthToken: false);
    bool isShootOut = false;
    late final ScoringSystem scoringSystem;
    scoringSystemResponse.fold((l) => scoringSystem = ScoringSystem.empty, (r) {
      isShootOut =
          r.pointsPerWinShootOut != null && r.pointPerLossShootOut != null;
      scoringSystem = r;
    });
    if (isShootOut) {
      final response = await _iTeamTournamentService
          .getGeneralTableByTournament(tournamentId, requiresAuthToken: false);
      response.fold(
          (l) => emit(state.copyWith(
              screenStatus: ScreenStatus.error,
              errorMessage: l.errorMessage)), (r) {
        emit(state.copyWith(
            screenStatus: ScreenStatus.loaded,
            scoringTournament: r,
            isShootout: isShootOut,
            scoringSystem: scoringSystem));
      });
    } else {
      final response = await _tournamentService
          .getScoringTournamentId(tournamentId, requiresAuthToken: false);
      response.fold(
          (l) => emit(state.copyWith(
              screenStatus: ScreenStatus.error,
              errorMessage: l.errorMessage)), (r) {
        emit(state.copyWith(
            screenStatus: ScreenStatus.loaded,
            scoringTournament: r,
            isShootout: isShootOut,
            scoringSystem: scoringSystem));
      });
    }
  }
}
