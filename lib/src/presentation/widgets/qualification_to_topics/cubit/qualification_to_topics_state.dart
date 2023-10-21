part of 'qualification_to_topics_cubit.dart';


class QualificationToTopicsState extends Equatable {
  final List<TopicEvaluation> listTopicsEvaluation;
  final int rating;
  final String? errorMessage;
  final BasicCubitScreenState screenStatus;

  const QualificationToTopicsState({
    this.listTopicsEvaluation = const [],
    this.rating = 0,
    this.errorMessage,
    this.screenStatus = BasicCubitScreenState.initial,
  });

  QualificationToTopicsState copyWith({
    List<TopicEvaluation>? listTopicsEvaluation,
    int? rating,
    String? errorMessage,
    BasicCubitScreenState? screenStatus,
  }) {
    return QualificationToTopicsState(
      listTopicsEvaluation: listTopicsEvaluation ?? this.listTopicsEvaluation,
      rating: rating ?? this.rating,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object?> get props => [
    listTopicsEvaluation,
    rating,
    screenStatus,
  ];
}
