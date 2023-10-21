part of 'rep_user_post_bloc.dart';

@freezed
class RepUserPostEvent with _$RepUserPostEvent {
  const factory RepUserPostEvent.started() = _Started;
  const factory RepUserPostEvent.requestPostsList({required int authorId}) =
      _RequestPostsList;
  const factory RepUserPostEvent.requestTeamsList({required int personId}) =
      _RequestTeamsList;
  const factory RepUserPostEvent.createPost() = _CreatePost;
  const factory RepUserPostEvent.deletePost() = _DeletePost;
  const factory RepUserPostEvent.selectTeam({required Team team}) = _SelectTeam;
  const factory RepUserPostEvent.selectPost({required UserPost post}) =
      _SelectPost;
  const factory RepUserPostEvent.onTitleChange(String title) = _OnTitleChange;
  const factory RepUserPostEvent.onDescriptionChange(String description) =
      _OnDescriptionChange;
  const factory RepUserPostEvent.onPostStatusChange(bool status) =
      _OnPostStatusChange;
  const factory RepUserPostEvent.changeTeamRPStatus(bool value) =
      _ChangeTeamRPStatus;
}
