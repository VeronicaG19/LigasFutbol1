part of 'request_team_by_league_cubit.dart';

class RequestTeamByLeagueState extends Equatable {
  final List<UserPost> postsList;
  final UserPost selectedPost;
  final Person contactInfo;
  final String? errorMessage;
  final BasicCubitScreenState screenStatus;

  const RequestTeamByLeagueState({
    this.postsList = const [],
    this.selectedPost = UserPost.empty,
    this.contactInfo = Person.empty,
    this.errorMessage,
    this.screenStatus = BasicCubitScreenState.initial,
  });

  RequestTeamByLeagueState copyWith({
    List<UserPost>? postsList,
    UserPost? selectedPost,
    Person? contactInfo,
    String? errorMessage,
    BasicCubitScreenState? screenStatus,
  }) {
    return RequestTeamByLeagueState(
      postsList: postsList ?? this.postsList,
      selectedPost: selectedPost ?? this.selectedPost,
      contactInfo: contactInfo ?? this.contactInfo,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object?> get props => [
        postsList,
        selectedPost,
        contactInfo,
        screenStatus,
      ];
}
