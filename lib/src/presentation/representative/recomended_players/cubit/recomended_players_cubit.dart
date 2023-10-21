import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/recommendations/dto/recomendationDTO.dart';
import '../../../../domain/recommendations/service/i_recommendation_service.dart';

part 'recomended_players_state.dart';

@injectable
class RecomendedPlayersCubit extends Cubit<RecomendedPlayersState> {
  RecomendedPlayersCubit(this._service) : super(RecomendedPlayersState());

  final IRecommendationService _service;
  final List<RecomendationDto> _originalRecList = [];

  Future<void> onGetRecomendations(int teamId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));

    final request = await _service.getRecomendationsByTeam(teamId);

    request.fold((l) => emit(state.copyWith(screenStatus: ScreenStatus.error)),
        (r) {
      _originalRecList.addAll(r);
      if (r.isEmpty) {
        emit(state.copyWith(
            screenStatus: ScreenStatus.nullData, recomendationsList: r));
      } else {
        emit(state.copyWith(
            screenStatus: ScreenStatus.loaded, recomendationsList: r));
      }
    });
  }

  void onFilterList(String input) async {
    final items = _originalRecList
        .where((element) =>
            input.isEmpty ||
            element.recommended!.toLowerCase().contains(input.toLowerCase()))
        .toList();
    emit(state.copyWith(recomendationsList: items));
  }

  Future<void> onResponseRecomendation(
      int teamId, int recomendationId, bool respons) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));

    final response =
        await _service.responseRecomendation(recomendationId, respons);

    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, errorMessage: r));
      onGetRecomendations(teamId);
    });
  }
}
