import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_match/detailMatchDTO.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/service/i_matches_service.dart';

part 'match_detail_state.dart';

@injectable
class MatchDetailCubit extends Cubit<MatcheDetailState> {
  MatchDetailCubit(this._matchesService) : super(const MatcheDetailState());

  final IMatchesService _matchesService;

  Future<void> getDetailMatchByPlayer({required int matchId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _matchesService.getDetailMatchByPlayer(matchId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(
          state.copyWith(screenStatus: ScreenStatus.loaded, detailMatchDTO: r));
    });
  }
}
