import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/service/i_qualification_service.dart';
import 'package:ligas_futbol_flutter/src/domain/topic_evaluation/entity/topic_evaluation.dart';
import 'package:ligas_futbol_flutter/src/domain/topic_evaluation/service/i_topic_evaluation_service.dart';

import '../../../../domain/qualification/dto/qualification_topics_list_dto/qualification_topic.dart';
import '../../../../domain/qualification/dto/save_qualifications_dto/save_qualification_dto.dart';
import '../../../../domain/qualification/entity/qualification.dart';

part 'qualification_to_topics_state.dart';

@injectable
class QualificationToTopicsCubit extends Cubit<QualificationToTopicsState> {
  QualificationToTopicsCubit(
      this._topicEvaluationService,
      this._qualificationService,
      ) : super(const QualificationToTopicsState());

  final ITopicEvaluationService _topicEvaluationService;
  final IQualificationService _qualificationService;

  Future<void> getTopicsEvaluationByType({required String type}) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));
    final response = await _topicEvaluationService.getTopicsEvaluationByType(type);

    response.fold(
            (l) => emit(state.copyWith(
              screenStatus: BasicCubitScreenState.error,
              errorMessage: l.errorMessage,
            )),
            (r) {
              print("TOPICOS --> $r");
              emit(
                  state.copyWith(
                    screenStatus: BasicCubitScreenState.loaded,
                    listTopicsEvaluation: r
                  )
              );
            }
    );
  }

  Future<void> createQualification() async {
    List<QualificationTopic> listQualificationTopic = [];
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));

    QualificationTopic qualificationTopic = QualificationTopic(
      //enabledFlag: 'Y',
      qualification: state.rating,
      /*qualificationId: Qualification(
        comments: 'PRUEBA FLUTTER',
        enabledFlag: 'Y',
        entityIdEvaluated: 12087,
        entityIdEvaluator: 769,
        leagueId: 15164,
        matchId: 12087,
        qualificationId: 0,
        teamPlayerId: 0,
        typeEvaluation: 'FIELD_TO_MATCH'
      ),*/
      //qualificationTopicId: 0,
      topicEvaluationId: const TopicEvaluation(
        //description: 'Evaluacion general de un jugador a el campo de juego',
        //enabledFlag: 'Y',
        //global: 'N',
        //secuence: 1,
        //topic: 'Evaluar el campo de juego',
        topicEvaluationId: 74,
        //type: 'FIELD_TO_MATCH'
      ),
      //topicName: 'FIELD_TO_MATCH'
    );

    listQualificationTopic.add(qualificationTopic);
    SaveQualificationDTO saveQualification = SaveQualificationDTO(
      qualification: const Qualification(
          comments: 'PRUEBA FLUTTER',
          //enabledFlag: 'Y',
          entityIdEvaluated: 12416,
          entityIdEvaluator: 782,
          leagueId: 15232,
          matchId: 12416,
          //qualificationId: 0,
          teamPlayerId: 0,
          typeEvaluation: 'FIELD_TO_MATCH'
      ),
      qualificationToTopicList: listQualificationTopic,
    );

    final response = await _qualificationService.createQualification(saveQualification);

    print('RESPUESTA CREAR CALIFICACION -->$response');
  }

  void updateRating(int newRating) {
    emit(state.copyWith(rating: newRating));
  }

}
