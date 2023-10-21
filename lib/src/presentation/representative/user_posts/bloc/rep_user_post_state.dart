part of 'rep_user_post_bloc.dart';

@freezed
class RepUserPostState with _$RepUserPostState {
  const factory RepUserPostState({
    @Default(<UserPost>[]) final List<UserPost> userPostsList,
    @Default(<Team>[]) final List<Team> teamList,
    @Default(UserPost.empty) final UserPost selectedPost,
    @Default(Team.empty) final Team selectedTeam,
    @Default(PostTitleValidator.pure()) final PostTitleValidator title,
    @Default(PostDescriptionValidator.pure())
    final PostDescriptionValidator description,
    @Default('N') final String postStatus,
    @Default(FormzStatus.pure) final FormzStatus status,
    @Default(BasicCubitScreenState.initial)
    final BasicCubitScreenState screenState,
    String? errorMessage,
  }) = _Initial;
}
