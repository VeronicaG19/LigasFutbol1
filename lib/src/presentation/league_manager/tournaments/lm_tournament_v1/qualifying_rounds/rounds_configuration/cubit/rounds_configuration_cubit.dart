import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/config_league/config_league_dto.dart';
import '../../../../../../../core/enums.dart';
import '../../../../../../../domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';
import '../../../../../../../domain/tournament/service/i_tournament_service.dart';

part 'rounds_configuration_state.dart';

@injectable
class RoundsConfigurationCubit extends Cubit<RoundsConfigurationState> {
  RoundsConfigurationCubit(this._tournamentService,) : super(const RoundsConfigurationState());

  final ITournamentService _tournamentService;

  Future<void> createRoundsConfiguration({required int tournamentId}) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final config = ConfigLeagueDTO(
      matchForRound: "1",
      numberOrFinals: "1",
      rounds: "CUARTOS",
        tournamentId: tournamentId
    );
    final response = await _tournamentService.createRoundsConfiguration(config);

    response.fold(
            (l) => emit(state.copyWith(
                errorMessage: l.errorMessage,
                screenState: BasicCubitScreenState.error)
            ), (r){
              emit(state.copyWith(screenState: BasicCubitScreenState.success));
    });
  }


  Future<void> getScoringTournamentId({required int tournamentId}) async {
    print("Valor del torneo---->$tournamentId");
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response =
    await _tournamentService.getScoringTournamentId(tournamentId);
    response.fold(
            (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");

      emit(state.copyWith(
          screenState: BasicCubitScreenState.loaded, scoringTournament: r));
    });
  }

  Future<void> onChangeMatchRound(value) async{
    emit(state.copyWith(matchForRound: value));
  }

}
