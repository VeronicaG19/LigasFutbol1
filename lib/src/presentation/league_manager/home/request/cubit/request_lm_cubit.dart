import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/roles/service/i_rol_service.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/league_description.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/league_name.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../domain/category/category.dart';
import '../../../../../domain/leagues/leagues.dart';
import '../../../../../domain/roles/entity/rol.dart';
import '../../../../../domain/roles/entity/user_rol.dart';
import '../../../../../domain/user_configuration/entity/user_configuration.dart';
import '../../../../../domain/user_requests/dto/request_to_admin_dto.dart';
import '../../../../../domain/user_requests/dto/request_to_league_dto.dart';
import '../../../../../domain/user_requests/dto/response_request_dto.dart';
import '../../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'request_lm_state.dart';

@injectable
class RequestLmCubit extends Cubit<RequestLmState> {
  RequestLmCubit(this._service, this._leagueService, this._categoryService,
      this._iRolService)
      : super(const RequestLmState());
  final IUserRequestsService _service;
  final ILeagueService _leagueService;
  final ICategoryService _categoryService;
  final IRolService _iRolService;

  void onLeagueDescriptionChange(String value) {
    final leagueDescrition = LeagueDescription.dirty(value);
    emit(state.copyWith(
        leagueDescription: leagueDescrition,
        formzStatus:
            Formz.validate([leagueDescrition, state.leagueDescription])));
  }

  void onLeagueNameChange(String value) {
    final leagueName = LeagueName.dirty(value);
    emit(state.copyWith(
        leagueName: leagueName,
        formzStatus: Formz.validate([leagueName, state.leagueName])));
  }

  Future<void> sendRequest({required int? partyId}) async {
    emit(state.copyWith(
      leagueName: LeagueName.dirty(state.leagueName.value),
      leagueDescription: LeagueDescription.dirty(state.leagueDescription.value),
    ));

    if (state.leagueName.valid == true &&
        state.leagueDescription.valid == true) {
      emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));

      final response = await _service.sendRequestToLeague(RequestToAdmonDTO(
        leagueName: state.leagueName.value,
        leagueDescription: state.leagueDescription.value,
        partyId: partyId,
        status: 0,
      ));

      response.fold(
        (l) => emit(state.copyWith(
          formzStatus: FormzStatus.submissionFailure,
          errorMessage: l.errorMessage,
          screenStatus: BasicCubitScreenState.error,
        )),
        (r) {
          print("Datos ${r}");
          emit(state.copyWith(
            formzStatus: FormzStatus.submissionSuccess
            // screenStatus :ScreenStatus.creatingRequest
            ,
            responseRequestDTO: r,
            requestCount: 1,
            screenStatus: BasicCubitScreenState.success,
          ));
        },
      );
    }
  }

  Future<void> onGetLeagues() async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));

    final response = await _leagueService.getAllLeagues();
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: BasicCubitScreenState.error,
            errorMessage: l.toString())),
        (r) => {
              emit(state.copyWith(
                  screenStatus: BasicCubitScreenState.loaded, leagues: r))
            });
  }

  Future<void> onChangeLeague(League leage) async {
    print('change lige');
    emit(state.copyWith(leageSlct: leage));
  }

  Future<void> getCategoriesByLeague(League league) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));

    final response =
        await _categoryService.getCategoriesByLeagueId(league.leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: BasicCubitScreenState.loaded,
            categoriesList: const [])),
        (r) => {
              emit(state.copyWith(
                  screenStatus: BasicCubitScreenState.loaded,
                  categoriesList: r,
                  catSelect: Category.empty))
            });
  }

  Future<void> onChangeCategory(Category category) async {
    emit(state.copyWith(catSelect: category));
  }

  Future<void> sendRequestTeamManager(
      {required int? partyId, required User urs}) async {
    if (!state.formzStatus.isValidated) return;
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    RequestToLeagueDTO requestToLeagueDTO = RequestToLeagueDTO(
      categoryId: state.catSelect.categoryId,
      leagueId: state.leageSlct.leagueId,
      nameTeam: state.leagueDescription.value,
      partyId: partyId,
    );
    final response = await _service.sendRequestNewTeam(requestToLeagueDTO);
    response.fold(
        (l) => emit(state.copyWith(
            formzStatus: FormzStatus.submissionFailure,
            errorMessage: l.errorMessage
            //, screenStatus: ScreenStatus.error
            )), (r) {
      print("Datos ${r}");
      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
      updateRole(Rolesnm.TEAM_MANAGER, urs);
    });
  }

  Future<void> sendRequestReferee(
      {required int? partyId, required User urs}) async {
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    final response = await _service.sendNewRefereeRequestToLeague(
        partyId!, state.leageSlct.leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            formzStatus: FormzStatus.submissionFailure,
            errorMessage: l.errorMessage
            //, screenStatus: ScreenStatus.error
            )), (r) {
      print("Datos ${r}");
      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
      updateRole(Rolesnm.REFEREE, urs);
    });
  }

  Future<void> getCountRequestFiltered(
      int partyId, RequestType requestType) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));

    final response =
        await _service.getRequestCountFiltered(partyId, requestType);

    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: BasicCubitScreenState.loaded, requestCount: 0)),
        (r) => emit(state.copyWith(
            screenStatus: BasicCubitScreenState.loaded, requestCount: r)));
  }

  Future<void> updateRole(Rolesnm role, User usr) async {
    emit(state.copyWith(screenStatus: BasicCubitScreenState.loading));
    Rol rol = Rol(orgId: 4, roleName: role.name);

    UserRol usrRol = UserRol(
        primaryFlag: 'Y',
        rol: rol,
        configuration: UserConfiguration.empty,
        userRolId: 0,
        user: usr);
    final response = await _iRolService.createUserRolAndUpdate(usrRol);

    response.fold(
        (l) => {
              emit(state.copyWith(
                  screenStatus: BasicCubitScreenState.error,
                  errorMessage: l.errorMessage))
            },
        (r) => {
              emit(state.copyWith(
                screenStatus: BasicCubitScreenState.loaded,
              )),
            });
  }
}
