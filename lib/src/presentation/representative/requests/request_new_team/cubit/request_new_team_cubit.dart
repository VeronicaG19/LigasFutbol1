import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/domain/category/service/i_category_service.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/service/i_league_service.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/category_id.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/dto/request_to_league_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/service/i_user_requests_service.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/team_name.dart';

import '../../../../../domain/leagues/entity/league.dart';
import '../../../../../domain/user_requests/league_id.dart';

part 'request_new_team_state.dart';

@injectable
class RequestNewTeamCubit extends Cubit<RequestNewTeamState> {
  RequestNewTeamCubit(
    this._userRequestsService,
    this._leagueService,
    this._categoryService,
  ) : super(const RequestNewTeamState());

  final IUserRequestsService _userRequestsService;
  final ILeagueService _leagueService;
  final ICategoryService _categoryService;

  void onCategoryIdChange(Category value) {
    final categoryId = CategoryId.dirty(value.categoryId.toString());
    emit(state.copyWith(
        categoryId: categoryId,
        formzStatus: Formz.validate([categoryId, state.categoryId]),
        categorySelect: value));
  }

  void onLeagueIdChange(League value) {
    final leagueId = LeagueId.dirty(value.leagueId.toString());
    emit(state.copyWith(
        leagueId: leagueId,
        formzStatus: Formz.validate([leagueId, state.leagueId]),
        leagueSelect: value));
    availableCategoriesByLeagueId(value.leagueId);
  }

  void onTeamNameChange(String value) {
    final teamName = TeamName.dirty(value);
    emit(state.copyWith(
        teamName: teamName,
        formzStatus: Formz.validate([teamName, state.teamName])));
  }

  Future<void> availableLeagues() async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _leagueService.getAllLeagues();
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Ligas--> ${r.length}");
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          leagueList: r,
          leagueSelect: r[0]));
      availableCategoriesByLeagueId(r[0].leagueId);
    });
  }

  Future<void> availableCategoriesByLeagueId(int leagueId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loadingCategories));
    final response = await _categoryService.getCategoriesByLeagueId(leagueId);
    response.fold((l) {
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          categoryList: const [],
          categorySelect: Category.empty));
    }, (r) {
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          categoryList: r.isNotEmpty ? r : const [],
          categorySelect: r.isNotEmpty ? r[0] : Category.empty));
    });
  }

  Future<void> sendRequestNewTeam({required int? partyId}) async {
    if (!state.formzStatus.isValidated) return;
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));

    RequestToLeagueDTO requestToLeagueDTO = RequestToLeagueDTO(
        partyId: partyId,
        categoryId: state.categorySelect.categoryId,
        leagueId: state.leagueSelect.leagueId,
        nameTeam: state.teamName.value);

    final response =
        await _userRequestsService.sendRequestNewTeam(requestToLeagueDTO);
    response.fold(
        (l) => emit(state.copyWith(
            formzStatus: FormzStatus.submissionFailure,
            errorMessage: l.errorMessage)), (r) {
      print("Respuesta--> ${r}");
      emit(state.copyWith(
          formzStatus: FormzStatus.submissionSuccess,
          screenStatus: ScreenStatus.teamCreated));
    });
  }
}
