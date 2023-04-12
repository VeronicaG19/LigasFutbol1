import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/recommendations/entity/recommendations.dart';
import 'package:ligas_futbol_flutter/src/domain/recommendations/service/i_recommendation_service.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/domain/team/service/i_team_service.dart';

part 'recommendation_state.dart';

@injectable
class RecommendationCubit extends Cubit<RecommendationState> {
  RecommendationCubit(this._teamService, this._recommendationService)
      : super(const RecommendationState());

  final ITeamService _teamService;
  final IRecommendationService _recommendationService;

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

  Future<void> postRecommendations(
      {required int teamId,
      required int recommendedBy,
      required int recommendedId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final recommendation = Recommendations(
        recommendedId: recommendedId,
        recommendedBy: recommendedBy,
        recommendedToId: teamId);
    final response =
        await _recommendationService.postRecommendation(recommendation);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(
          state.copyWith(screenStatus: ScreenStatus.succes, recommendation: r));
    });
  }
}
