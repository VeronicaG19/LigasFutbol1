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
    print("> onLoadInitialData $refereeId");
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final request =
        await _matchesService.getRefereeMatches(refereeId: refereeId);
    emit(state.copyWith(
        screenState: BasicCubitScreenState.loaded, matches: request));
  }

  Future<void> onPressStartGame({
    required int refereeId,
    required RefereeMatchDTO match,
  }) async {
    print("> onPressStartGame $refereeId");

    emit(state.copyWith(screenState: BasicCubitScreenState.sending));

    final response = await _matchesService.startMatch(match.matchId!);

    response.fold(
      (l) => emit(state.copyWith(screenState: BasicCubitScreenState.error)),
      (r) {
        print("> Respuesta");
        print("$r");
        emit(state.copyWith(screenState: BasicCubitScreenState.success));
        onLoadInitialData(refereeId);
      },
    );
  }
}
