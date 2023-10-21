import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/service/i_matches_service.dart';

import '../../../../domain/matches/dto/referee_match.dart';

part 'ref_matches_state.dart';

@injectable
class RefMatchesCubit extends Cubit<RefMatchesState> {
  RefMatchesCubit(this._matchesService) : super(const RefMatchesState());

  final IMatchesService _matchesService;

  Future<void> onLoadInitialData(int refereeId) async {
    List<RefereeMatchDTO>? finishedMatchesList = [];
    List<RefereeMatchDTO>? otherMatchesList = [];

    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final request =
        await _matchesService.getRefereeMatches(refereeId: refereeId);
    for (final e in request) {
      if (e.estado == "Finalizado") {
        finishedMatchesList.add(e);
      } else {
        otherMatchesList.add(e);
      }
    }
    emit(state.copyWith(
        screenState: BasicCubitScreenState.loaded,
        matches: request,
        finishedMatchesList: finishedMatchesList,
        otherMatchesList: otherMatchesList));
  }

  Future<void> onPressStartGame({
    required int refereeId,
    required RefereeMatchDTO match,
  }) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));

    final response = await _matchesService.startMatch(match.matchId!);

    response.fold(
      (l) => emit(state.copyWith(screenState: BasicCubitScreenState.error)),
      (r) {
        emit(state.copyWith(
            screenState: BasicCubitScreenState.success, statusMessage: "1"));
        onLoadInitialData(refereeId);
      },
    );
  }
}
