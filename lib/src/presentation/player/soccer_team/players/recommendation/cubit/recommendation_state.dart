part of 'recommendation_cubit.dart';

enum ScreenStatus { initial, loading, loaded, error, succes }

class RecommendationState extends Equatable {
  final List<Team> teamList;
  final Recommendations recommendation;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const RecommendationState({
    this.teamList = const [],
    this.recommendation = Recommendations.empty,
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  RecommendationState copyWith({
    List<Team>? teamList,
    Recommendations? recommendation,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return RecommendationState(
      teamList: teamList ?? this.teamList,
      recommendation: recommendation ?? this.recommendation,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [
        teamList,
        recommendation,
        screenStatus,
      ];
}
