import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/qualification/entity/qualification.dart';
import '../../../../domain/qualification/service/i_qualification_service.dart';

part 'myrattings_state.dart';

@injectable
class MyrattingsCubit extends Cubit<MyrattingsState> {
  MyrattingsCubit(this._service) : super(MyrattingsState());

   final IQualificationService _service;

    Future<void> onGetCalifications(int matchId, List<String> typeFilter) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    List<Qualification> califications = List.from(state.calificationsList);
    for(var filter in typeFilter){
      final response = await _service.getRatingDetailList(matchId, filter);
      response.fold((l) => null, (r) {
        califications.addAll(r);
      });
    }
    
    
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, calificationsList: califications));
  }

  String onGetEvaluatorType(String typeEvaluation){
    switch (typeEvaluation) {
      case 'PLAYER_TO_FIELD':
        return 'Jugador';
      case 'REFEREE_TO_PLAYER':
      return 'Árbitro';
      case 'REFEREE_TO_TEAM':
       return 'Árbitro';
      case 'REFEREE_TO_FIELD':
       return 'Árbitro';
      case 'FIELD_TO_MATCH':
       return 'Dueño de campo';
      case 'PLAYER_TO_REFERE':
       return 'Jugador';
      default:
      return '';
    }
    /**
     * PLAYER_TO_FIELD
REFEREE_TO_PLAYER
REFEREE_TO_TEAM
REFEREE_TO_FIELD
FIELD_TO_MATCH
PLAYER_TO_REFERE
     */
  }
}
