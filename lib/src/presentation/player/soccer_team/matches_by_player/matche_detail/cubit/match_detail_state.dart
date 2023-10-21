part of 'match_detail_cubit.dart';

enum ScreenStatus { initial, loading, loaded, error, success }

class MatcheDetailState extends Equatable {
  final List<DetailMatchDTO> detailMatchDTO;
  final List<TopicEvaluation> listTopicsEvaluation;
  final List<QualificationDTO> listDetailQualification;
  final QualificationDTO existQualification;
  final RatingTopicsDTO refereeRating;
  final RatingTopicsDTO ownerFieldRating;
  final Player playerInfo;
  final int rating;
  final String comments;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const MatcheDetailState({
    this.detailMatchDTO = const [],
    this.playerInfo = Player.empty,
    this.listTopicsEvaluation = const [],
    this.listDetailQualification = const [],
    this.existQualification = QualificationDTO.empty,
    this.refereeRating = RatingTopicsDTO.empty,
    this.ownerFieldRating = RatingTopicsDTO.empty,
    this.rating = 0,
    this.comments = '',
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  MatcheDetailState copyWith({
    List<DetailMatchDTO>? detailMatchDTO,
    Player? playerInfo,
    List<TopicEvaluation>? listTopicsEvaluation,
    List<QualificationDTO>? listDetailQualification,
    QualificationDTO? existQualification,
    RatingTopicsDTO? refereeRating,
    RatingTopicsDTO? ownerFieldRating,
    int? rating,
    String? comments,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return MatcheDetailState(
      detailMatchDTO: detailMatchDTO ?? this.detailMatchDTO,
      playerInfo: playerInfo ?? this.playerInfo,
      listTopicsEvaluation: listTopicsEvaluation ?? this.listTopicsEvaluation,
      listDetailQualification:
          listDetailQualification ?? this.listDetailQualification,
      existQualification: existQualification ?? this.existQualification,
      rating: rating ?? this.rating,
      refereeRating: refereeRating ?? this.refereeRating,
      comments: comments ?? this.comments,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
      ownerFieldRating: ownerFieldRating ?? this.ownerFieldRating
    );
  }

  @override
  List<Object> get props => [
        detailMatchDTO,
        playerInfo,
        listTopicsEvaluation,
        listDetailQualification,
        existQualification,
        rating,
        refereeRating,
        comments,
        screenStatus,
        ownerFieldRating
      ];
}
