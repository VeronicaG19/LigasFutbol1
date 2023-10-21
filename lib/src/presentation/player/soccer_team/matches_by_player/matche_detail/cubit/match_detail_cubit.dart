import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_match/detailMatchDTO.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/service/i_matches_service.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/dto/qualification_dto/qualification_dto.dart';

import '../../../../../../domain/player/entity/player.dart';
import '../../../../../../domain/player/service/i_player_service.dart';
import '../../../../../../domain/qualification/dto/qualification_topics_list_dto/qualification_topic.dart';
import '../../../../../../domain/qualification/dto/rating_topics/rating_topics_dto.dart';
import '../../../../../../domain/qualification/dto/save_qualifications_dto/save_qualification_dto.dart';
import '../../../../../../domain/qualification/entity/qualification.dart';
import '../../../../../../domain/qualification/service/i_qualification_service.dart';
import '../../../../../../domain/topic_evaluation/entity/topic_evaluation.dart';
import '../../../../../../domain/topic_evaluation/service/i_topic_evaluation_service.dart';

part 'match_detail_state.dart';

@injectable
class MatchDetailCubit extends Cubit<MatcheDetailState> {
  MatchDetailCubit(
    this._matchesService,
    this._topicEvaluationService,
    this._qualificationService,
    this._playerService,
  ) : super(const MatcheDetailState());

  final IMatchesService _matchesService;
  final ITopicEvaluationService _topicEvaluationService;
  final IQualificationService _qualificationService;
  final IPlayerService _playerService;

  void updateRating(int newRating) {
    emit(state.copyWith(rating: newRating));
  }

  void onCommentsChanged(String value) {
    //final description = SimpleTextValidator.dirty(value);
    emit(state.copyWith(comments: value));
  }

  Future<void> getDetailMatchByPlayer({required int matchId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _matchesService.getDetailMatchByPlayer(matchId);
    final refereeRatingRequest =
        await _qualificationService.getRatingTopics(matchId);
    final refereeRating = refereeRatingRequest.getOrElse(() => []);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          refereeRating: refereeRating.firstWhere(
              (element) => element.typeEvaluation == 'PLAYER_TO_REFERE',
              orElse: () => RatingTopicsDTO.empty),
          ownerFieldRating: refereeRating.firstWhere(
              (element) => element.typeEvaluation == 'FIELD_TO_MATCH',
              orElse: () => RatingTopicsDTO.empty),
          detailMatchDTO: r));
    });
  }

  Future<void> getMatchDeailByEvent({required int eventId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _matchesService.getMatchDetailByEventId(eventId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      getDetailMatchByPlayer(matchId: r.matchId!);
    });
  }

  Future<void> loadInfoPlayer({required int personId}) async {
    final request = await _playerService.getDataPlayerByPartyId(personId);
    request.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(playerInfo: r));
    });
  }

  Future<void> getTopicsEvaluationByType(
      {required String type,
      int? personId,
      required int evaluatedId,
      required int evaluatorId,
      required int leagueId,
      required int matchId,
      required String typeQualification}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response =
        await _topicEvaluationService.getTopicsEvaluationByType(type);

    if (type == 'PLAYER_TO_REFERE' || type == 'PLAYER_TO_FIELD') {
      loadInfoPlayer(personId: personId ?? 0);
    }

    response.fold(
        (l) => emit(state.copyWith(
              screenStatus: ScreenStatus.error,
              errorMessage: l.errorMessage,
            )), (r) {
      print("TOPICOS --> $r");
      // emit(state.copyWith(
      //    screenStatus: ScreenStatus.loaded, listTopicsEvaluation: r));
      getExistQualification(
          evaluatedId, evaluatorId, leagueId, matchId, typeQualification, r);
    });
  }

  Future<void> getExistQualification(
      int evaluatedId,
      int evaluatorId,
      int leagueId,
      int matchId,
      String typeQualification,
      List<TopicEvaluation> listTopicsEvaluation) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));

    final response = await _qualificationService.getExistQualification(
      evaluatedId,
      evaluatorId,
      leagueId,
      matchId,
      typeQualification,
    );
    print("Respuesta----------------------->");
    print(response);
    response.fold(
        (l) => {
              emit(state.copyWith(
                  screenStatus: ScreenStatus.error,
                  errorMessage: l.errorMessage,
                  listTopicsEvaluation: listTopicsEvaluation)),
              print("error--->${l.errorMessage}")
            }, (r) {
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          existQualification: r,
          listTopicsEvaluation: listTopicsEvaluation));
    });
  }

  Future<void> getListQualification(int matchId, String type) async {
    final response = await _qualificationService.getQualificationByMatchAndType(
        matchId, type);

    response.fold(
        (l) => emit(state.copyWith(screenStatus: ScreenStatus.loaded)), (r) {
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded, listDetailQualification: r));
    });
  }

  Future<void> createQualification(
      {required int topicId,
      required int idEvaluator,
      required int idEvaluated,
      required int leagueId,
      required int matchId,
      required String typeEvaluation,
      int? teamPlayerId,
      int? teamId}) async {
    print("Datos recibidos------------------------------------------>");
    print('evualator $idEvaluator');
    print('avualated $idEvaluated');
    print('match id $matchId');
    if (state.comments.length > 250) return;
    List<QualificationTopic> listQualificationTopic = [];
    emit(state.copyWith(screenStatus: ScreenStatus.loading));

    QualificationTopic qualificationTopic = QualificationTopic(
      qualification: state.rating,
      topicEvaluationId: TopicEvaluation(
        topicEvaluationId: topicId,
      ),
    );

    listQualificationTopic.add(qualificationTopic);

    SaveQualificationDTO saveQualification = SaveQualificationDTO(
      qualification: Qualification(
          comments: state.comments,
          enabledFlag: 'Y',
          entityIdEvaluated: idEvaluated,
          entityIdEvaluator: idEvaluator,
          leagueId: leagueId,
          matchId: matchId,
          teamPlayerId: teamPlayerId ?? null,
          typeEvaluation: typeEvaluation),
      qualificationToTopicList: listQualificationTopic,
    );
    print(
        "Objeto------------------------------------------------------------->");
    print(saveQualification.toJson());

    final response = await _qualificationService
        .createQualification(saveQualification, teamId: teamId ?? null);

    response.fold(
        (l) => emit(state.copyWith(
              screenStatus: ScreenStatus.error,
              errorMessage: l.errorMessage,
            )), (r) {
      emit(state.copyWith(screenStatus: ScreenStatus.success));
    });
  }
}
