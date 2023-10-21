import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums.dart';
import '../../../../core/validators/post_description_validator.dart';
import '../../../../core/validators/post_title_validator.dart';
import '../../../../domain/team/entity/team.dart';
import '../../../../domain/team/service/i_team_service.dart';
import '../../../../domain/user_post/entity/user_post.dart';
import '../../../../domain/user_post/service/i_user_post_service.dart';

part 'rep_user_post_bloc.freezed.dart';
part 'rep_user_post_event.dart';
part 'rep_user_post_state.dart';

@injectable
class RepUserPostBloc extends Bloc<RepUserPostEvent, RepUserPostState> {
  final IUserPostService _service;
  final ITeamService _teamService;

  RepUserPostBloc(this._service, this._teamService)
      : super(const RepUserPostState()) {
    on<RepUserPostEvent>((event, emit) async {
      await event.map(
          started: (_) => null,
          requestPostsList: (value) async =>
              await _onRequestPostList(value, emit),
          createPost: (_) => _onCreateNewPost(emit),
          deletePost: (_) async => await _onDeletePost(emit),
          selectPost: (_SelectPost value) async =>
              await _onSelectPost(value, emit),
          requestTeamsList: (_RequestTeamsList value) async =>
              await _onRequestTeamList(value, emit),
          selectTeam: (_SelectTeam value) async =>
              await _onSelectTeam(value, emit),
          onTitleChange: (_OnTitleChange value) => _onTitleChange(value, emit),
          onDescriptionChange: (_OnDescriptionChange value) =>
              _onDescriptionChange(value, emit),
          onPostStatusChange: (_OnPostStatusChange value) =>
              _onPostStatusChange(value, emit),
          changeTeamRPStatus: (_ChangeTeamRPStatus value) async =>
              await _onChangeTeamRPStatus(value, emit));
    });
  }

  Future<void> _onRequestPostList(
      _RequestPostsList event, Emitter<RepUserPostState> emit) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final request = await _service.getPostByAuthorAndType(
        authorId: event.authorId, type: 'TEAM_SEARCH_PLAYER');
    emit(
      state.copyWith(
        screenState: BasicCubitScreenState.loaded,
        userPostsList: request,
      ),
    );
  }

  Future<void> _onRequestTeamList(
      _RequestTeamsList event, Emitter<RepUserPostState> emit) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response =
        await _teamService.getTeamsFindByRepresentant(event.personId);
    response.fold(
      (l) => emit(state.copyWith(
          errorMessage: l.errorMessage,
          screenState: BasicCubitScreenState.error)),
      (r) {
        if (r.isEmpty) {
          emit(state.copyWith(
              screenState: BasicCubitScreenState.loaded,
              userPostsList: [],
              teamList: r));
        } else {
          r.sort((a, b) => a.teamNameValidated
              .toLowerCase()
              .compareTo(b.teamNameValidated.toLowerCase()));
          emit(state.copyWith(teamList: r, selectedTeam: r.first));
          add(RepUserPostEvent.requestPostsList(authorId: r.first.teamId ?? 0));
        }
      },
    );
  }

  Future<void> _onCreateNewPost(Emitter<RepUserPostState> emit) async {
    final valid = Formz.validate([state.description, state.title]);
    if (!valid.isValidated) {
      emit(state.copyWith(
          description: PostDescriptionValidator.dirty(state.description.value),
          title: PostTitleValidator.dirty(state.title.value)));
      return;
    }
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    if (state.selectedPost.postId == 0) {
      final post = UserPost.empty.copyWith(
        title: state.title.value,
        description: state.description.value,
        postType: 'TEAM_SEARCH_PLAYER',
        statusPost: state.postStatus,
        expirationDate: DateTime.now(),
        publicationMadeById: state.selectedTeam.teamId ?? 0,
      );
      final request = await _service.createNewPost(post);
      request.fold(
          (l) => emit(state.copyWith(
              errorMessage: l.errorMessage,
              status: FormzStatus.submissionFailure)), (r) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        add(RepUserPostEvent.requestPostsList(
            authorId: state.selectedTeam.teamId ?? 0));
      });
    } else {
      final request = await _service.editNewPost(state.selectedPost.copyWith(
        title: state.title.value,
        description: state.description.value,
        statusPost: state.postStatus,
      ));
      request.fold((l) {
        print("error---->");
        print(l.errorMessage);
        emit(state.copyWith(
            errorMessage: l.errorMessage,
            status: FormzStatus.submissionFailure));
      }, (r) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        add(RepUserPostEvent.requestPostsList(
            authorId: state.selectedTeam.teamId ?? 0));
      });
    }
  }

  Future<void> _onDeletePost(Emitter<RepUserPostState> emit) async {
    _service.deleteNewPost(state.selectedPost.postId);
    final list = <UserPost>[];
    list.addAll(state.userPostsList);
    list.removeWhere((element) => element == state.selectedPost);
    emit(state.copyWith(userPostsList: list, selectedPost: UserPost.empty));
  }

  Future<void> _onSelectTeam(
      _SelectTeam event, Emitter<RepUserPostState> emit) async {
    emit(state.copyWith(selectedTeam: event.team));
    add(RepUserPostEvent.requestPostsList(authorId: event.team.teamId ?? 0));
  }

  Future<void> _onSelectPost(
      _SelectPost event, Emitter<RepUserPostState> emit) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.initial));
    await Future.delayed(const Duration(milliseconds: 100));
    if (event.post.postId == 0) {
      emit(state.copyWith(
          selectedPost: UserPost.empty,
          title: const PostTitleValidator.pure(),
          description: const PostDescriptionValidator.pure(),
          screenState: BasicCubitScreenState.loaded,
          postStatus: 'N'));
    } else {
      emit(state.copyWith(
          selectedPost: event.post,
          title: PostTitleValidator.dirty(event.post.title),
          description: PostDescriptionValidator.dirty(event.post.description),
          screenState: BasicCubitScreenState.loaded,
          postStatus: event.post.statusPost));
    }
  }

  Future<void> _onTitleChange(
      _OnTitleChange event, Emitter<RepUserPostState> emit) async {
    final title = PostTitleValidator.dirty(event.title);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([title, state.description]),
    ));
  }

  Future<void> _onDescriptionChange(
      _OnDescriptionChange event, Emitter<RepUserPostState> emit) async {
    final description = PostDescriptionValidator.dirty(event.description);
    emit(state.copyWith(
        description: description,
        status: Formz.validate([description, state.title])));
  }

  Future<void> _onPostStatusChange(
      _OnPostStatusChange event, Emitter<RepUserPostState> emit) async {
    emit(state.copyWith(postStatus: event.status ? 'Y' : 'N'));
  }

  Future<void> _onChangeTeamRPStatus(
      _ChangeTeamRPStatus event, Emitter<RepUserPostState> emit) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.sending));
    final status = !event.value ? 'N' : 'Y';
    // emit(state.copyWith(
    //     selectedTeam: state.selectedTeam.copyWith(requestPlayers: status)));
    final request = await _teamService.updateTeamByTeamService(
        state.selectedTeam.copyWith(requestPlayers: status));
    request.fold(
        (l) => emit(state.copyWith(
            selectedTeam: state.selectedTeam,
            screenState: BasicCubitScreenState.error)), (r) {
      final teams = <Team>[];
      teams.addAll(state.teamList);
      teams.removeWhere((element) => element.teamId == r.teamId);
      teams.add(r);
      teams.sort((a, b) => a.teamNameValidated
          .toLowerCase()
          .compareTo(b.teamNameValidated.toLowerCase()));
      emit(state.copyWith(
          teamList: teams,
          selectedTeam: r,
          screenState: BasicCubitScreenState.success));
    });
  }
}
