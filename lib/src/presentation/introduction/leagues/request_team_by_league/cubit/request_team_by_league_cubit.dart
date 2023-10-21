import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../core/enums.dart';
import '../../../../../domain/team/entity/team.dart';
import '../../../../../domain/team/service/i_team_service.dart';
import '../../../../../domain/user_post/entity/user_post.dart';
import '../../../../../domain/user_post/service/i_user_post_service.dart';

part 'request_team_by_league_state.dart';

@injectable
class RequestTeamByLeagueCubit extends Cubit<RequestTeamByLeagueState> {
  RequestTeamByLeagueCubit(
      this._postService, this._teamService, this._userRepository)
      : super(const RequestTeamByLeagueState());

  final IUserPostService _postService;
  final ITeamService _teamService;
  final UserRepository _userRepository;

  Future<void> getRequestTeamByLeague({int? tournamentId}) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));
    final response = await _postService.getPostsByTournament(tournamentId ?? 0,
        requiresAuthToken: false);
    emit(state.copyWith(
        screenStatus: BasicCubitScreenState.loaded, postsList: response));
  }

  Future<void> onSelectPost(UserPost post, bool withContactInfo) async {
    emit(state.copyWith(
        screenStatus: BasicCubitScreenState.validating, selectedPost: post));
    if (withContactInfo) {
      final teamReq = await _teamService.getDetailTeamByIdTeam(post.madeById,
          requiresAuthToken: false);
      final teamId = teamReq.getOrElse(() => Team.empty).firstManager ?? 0;
      final userReq = await _userRepository.getPersonDataByPersonId(teamId,
          requiresAuthToken: false);
      emit(state.copyWith(
          screenStatus: BasicCubitScreenState.loaded,
          contactInfo: userReq.getOrElse(() => Person.empty)));
      return;
    }
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loaded));
  }
}
