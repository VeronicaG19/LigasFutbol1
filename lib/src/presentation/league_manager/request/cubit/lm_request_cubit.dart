import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../core/enums.dart';
import '../../../../domain/category/category.dart';
import '../../../../domain/team/entity/team.dart';
import '../../../../domain/team/service/i_team_service.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';
import '../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'lm_request_state.dart';

@Injectable()
class LmRequestCubit extends Cubit<LmRequestState> {
  LmRequestCubit(this._service, this._userRepository, this._teamService,
      this._categoryService)
      : super(const LmRequestState());

  final IUserRequestsService _service;
  final ITeamService _teamService;
  final UserRepository _userRepository;
  final ICategoryService _categoryService;

  final List<UserRequests> _leagueToReferee = [];
  final List<UserRequests> _refereeToLeague = [];
  final List<UserRequests> _teamToTournament = [];
  final List<UserRequests> _tournamentToTeam = [];
  final List<UserRequests> _teamToLeague = [];

  Future<void> onLoadInitialData(int leagueId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));

    final teamToL = await _service.getRequestsTeamToLeague(leagueId: leagueId);
    final leagueToRef =
        await _service.getRequestLeagueToReferee(leagueId: leagueId);
    final refToLeague =
        await _service.getRequestRefereeToLeague(leagueId: leagueId);
    final teamToTournamentR =
        await _service.getRequestTeamToTournament(leagueId: leagueId);
    final tournamentToTeamR =
        await _service.getRequestTournamentToTeam(leagueId: leagueId);

    _teamToLeague.addAll(teamToL);
    _leagueToReferee.addAll(leagueToRef);
    _refereeToLeague.addAll(refToLeague);
    _teamToTournament.addAll(teamToTournamentR);
    _tournamentToTeam.addAll(tournamentToTeamR);

    emit(state.copyWith(
      adminRequestList: _teamToLeague,
      refereeRequestList: _leagueToReferee,
      tournamentList: _tournamentToTeam,
      screenState: BasicCubitScreenState.loaded,
      notificationCounterRL: _teamToLeague.length,
      notificationCounterRRS: _leagueToReferee.length,
      notificationCounterRRR: _refereeToLeague.length,
      notificationCounterRTS: _tournamentToTeam.length,
      notificationCounterRTR: _teamToTournament.length,
    ));
  }

  Future<void> onLoadLeagueRequestData(UserRequests request) async {
    final teamRequest =
        await _teamService.getDetailTeamByIdTeam(request.requestMadeById);
    final team = teamRequest.getOrElse(() => Team.empty);
    final categoryRequest = await _categoryService
        .getCategoriesByLeagueId(request.requestToId ?? 0);
    final categoryList = categoryRequest.getOrElse(() => []);
    final response = await _userRepository
        .getPersonDataByPersonId(team.firstManager ?? team.secondManager ?? 0);
    emit(state.copyWith(
        representative: response.getOrElse(() => Person.empty),
        selectedTeam: team,
        categoryList: categoryList));
  }

  void onChangeTeamCategory(Category? category) {
    emit(state.copyWith(
        selectedTeam: state.selectedTeam.copyWith(categoryId: category)));
  }

  void onChangeTeamName(String value) {
    emit(state.copyWith(
        selectedTeam: state.selectedTeam.copyWith(teamName: value)));
  }

  void onChangeRequestType(int value) {
    if (value == 0) {
      emit(state.copyWith(
          refereeRequestList: _refereeToLeague,
          requestStatus: 1,
          tournamentList: _teamToTournament));
    } else {
      emit(state.copyWith(
          refereeRequestList: _leagueToReferee,
          requestStatus: 0,
          tournamentList: _tournamentToTeam));
    }
  }

  void onChangeTap(int index) {
    switch (index) {
      case 0:
        emit(state.copyWith(
            currentRequestType: LMRequestType.league,
            requestStatus: 0,
            adminRequestList: _teamToLeague));
        break;
      case 1:
        emit(state.copyWith(
            currentRequestType: LMRequestType.tournament,
            requestStatus: 0,
            tournamentList: _tournamentToTeam));
        break;
      case 2:
        emit(state.copyWith(
            currentRequestType: LMRequestType.referee,
            requestStatus: 0,
            refereeRequestList: _refereeToLeague));
        break;
      case 3:
        emit(state.copyWith(
          currentRequestType: LMRequestType.dateChange,
          requestStatus: 0,
        ));
        break;
      default:
        emit(state.copyWith(currentRequestType: LMRequestType.league));
    }
  }

  void onFilterRequestList(String input) {
    if (state.currentRequestType == LMRequestType.league) {
      final requests = _service.filterRequestList(input, _teamToLeague);
      emit(state.copyWith(adminRequestList: requests));
    } else if (state.currentRequestType == LMRequestType.referee) {
      if (state.requestStatus == 0) {
        final requests = _service.filterRequestList(input, _leagueToReferee);
        emit(state.copyWith(refereeRequestList: requests));
      } else {
        final requests = _service.filterRequestList(input, _refereeToLeague);
        emit(state.copyWith(refereeRequestList: requests));
      }
    } else if (state.currentRequestType == LMRequestType.tournament) {
      if (state.requestStatus == 0) {
        final requests = _service.filterRequestList(input, _tournamentToTeam);
        emit(state.copyWith(tournamentList: requests));
      } else {
        final requests = _service.filterRequestList(input, _teamToTournament);
        emit(state.copyWith(tournamentList: requests));
      }
    }
  }

  void onCommentChanged(String? value) {
    emit(state.copyWith(comment: value));
  }

  Future<void> onCancelRequest(int? requestId, int? leagueId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.sending));
    final response = await _service.cancelUserRequest(requestId ?? 0);
    response.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.errorMessage,
            screenState: BasicCubitScreenState.error)), (r) {
      emit(state.copyWith(screenState: BasicCubitScreenState.success));
      _teamToLeague.clear();
      _leagueToReferee.clear();
      _refereeToLeague.clear();
      _teamToTournament.clear();
      _tournamentToTeam.clear();
      onLoadInitialData(leagueId ?? 0);
    });
  }

  Future<void> onSubmitRequest(UserRequests request, bool status) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.sending));
    final response = await _service.updateAdminUserRequest(
        request.requestId, status,
        comment: state.comment);
    response.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.errorMessage,
            screenState: BasicCubitScreenState.error)), (r) {
      emit(state.copyWith(screenState: BasicCubitScreenState.success));
      _teamToLeague.clear();
      _leagueToReferee.clear();
      _refereeToLeague.clear();
      _teamToTournament.clear();
      _tournamentToTeam.clear();
      onLoadInitialData(request.requestToId!);
    });
  }
}
