import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/domain/category/service/i_category_service.dart';
import 'package:ligas_futbol_flutter/src/domain/referee/referee_last_name.dart';
import 'package:ligas_futbol_flutter/src/domain/referee/referee_name.dart';
import 'package:ligas_futbol_flutter/src/domain/sign_up/models.dart';
import 'package:ligas_futbol_flutter/src/domain/team/dto/create_team/create_team_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team/dto/team_league_manager_dto/team_league_manager_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/domain/team/service/i_team_service.dart';
import 'package:ligas_futbol_flutter/src/domain/team/validator/team_name.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/service/i_team_tournament_service.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../core/models/common_pageable_response.dart';
import '../../../../domain/category/validator/category_id.dart';

part 'team_league_manager_state.dart';

@injectable
class TeamLeagueManagerCubit extends Cubit<TeamLeagueManagerState> {
  TeamLeagueManagerCubit(
      this._service,
      this._teamTournamentService,
      this._categoryService,
      this._authenticationBloc,
      this._repository,
      this.userRepository)
      : super(TeamLeagueManagerState());

  final ITeamService _service;
  final ITeamTournamentService _teamTournamentService;
  final ICategoryService _categoryService;
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _repository;
  final UserRepository userRepository;
  final List<TeamLeagueManagerDTO> _originalTeamList = [];
  int page = 0;
  late int leagueId;
  Future<void> getTeams(int league) async {
    leagueId = league;
    print(
        "Liga seleccionada ${_authenticationBloc.state.leagueManager.leagueId}");
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    //   final response = await _service.getAllTeams(page: page, size: 21);
    final response = await _service.getAllTeamsByLeague(
        page: page, size: 21, leagueId: leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      _originalTeamList.clear();
      _originalTeamList.addAll(r.content);
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, teamPageable: r));
    });
  }

  void onNextPage() {
    if (page + 1 > state.teamPageable.totalPages) {
      return;
    }
    page++;
    getTeams(leagueId);
  }

  void onPreviousPage() {
    if (page <= 0) {
      return;
    }
    page--;
    getTeams(leagueId);
  }

  void goToLastPage() {
    if (page == state.teamPageable.totalPages) {
      return;
    }
    page = state.teamPageable.totalPages - 1;
    getTeams(leagueId);
  }

  void goToFirstPage() {
    print("liga--->${leagueId}");
    if (page == 0) {
      return;
    }
    page = 0;
    getTeams(leagueId);
  }

  void onFilterList(String input) {
    final items = _originalTeamList
        .where((element) =>
            input.isEmpty ||
            element.teamNameValidated
                .toLowerCase()
                .contains(input.toLowerCase()))
        .toList();
    emit(state.copyWith(
        teamPageable: state.teamPageable.copyWith(content: items)));
  }

  Future<void> getUpdateTeamByCategoryByTournamentByAndLeagueId(
      {required int legueId, required int personId}) async {
    print("Valor de la liga---->$legueId");
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading,
    ));
    final response = await _categoryService.getCategoriesByLeagueId2(legueId);
    final response2 = await userRepository.getPersonDataByPersonId(personId);
    response2.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.loaded, errorMessage: l.message)), (r) {
      Category categoryValue = Category.empty;
      for (final e in response) {
        if (e == state.categorySelected) {
          categoryValue = e;
        }
      }
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          infoManager: r,
          categoryList: response,
          categorySelected: categoryValue));
    });
  }

  Future<void> getCategoryByTournamentByAndLeagueId(
      {required int legueId}) async {
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading,
    ));
    final response = await _categoryService.getCategoriesByLeagueId(legueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) async {
      print("Datos ------ ${r}");
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          categoryList: r,
          categorySelected: r.isEmpty ? null : r.first));
    });
  }

  void onChangeTeamName(String value) {
    final teamName = TeamName.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          teamName,
          state.refereeLastName,
          state.refereeLastName,
          state.refereeName,
        ]),
        teamName: teamName));
  }

  void onChangeUpdateTeam(Team team) {
    final teamName = TeamName.dirty(team.teamName!);
    emit(state.copyWith(
      teamName: teamName,
      categorySelected: team.categoryId,
    ));
  }

  void onChangeRefereeFirstName(String value) {
    final refereeName = RefereeName.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          refereeName,
          state.refereeLastName,
          state.teamName,
          state.refereeLastName,
        ]),
        refereeName: refereeName));
  }

  void onChangeRefereeLastName(String value) {
    final refereeLastName = RefereeLastName.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          refereeLastName,
          state.refereeLastName,
          state.refereeName,
          state.teamName,
        ]),
        refereeLastName: refereeLastName));
  }

  void onVerificationSenderChanged(String value) {
    final verificationSender = VerificationSender.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          verificationSender,
          state.refereeLastName,
          state.refereeLastName,
          state.refereeName,
          state.teamName,
        ]),
        verificationSender: verificationSender));
  }

  void onPhotoTeamChange({XFile? xFile, CroppedFile? file}) async {
    final list = await file?.readAsBytes() ?? await xFile?.readAsBytes();
    final photo = base64Encode(list!);

    emit(state.copyWith(photoTeamSelected: photo, showImage1: xFile));
  }

  void onUniformLocalImageChange({XFile? xFile, CroppedFile? file}) async {
    final list = await file?.readAsBytes() ?? await xFile?.readAsBytes();
    final photo = base64Encode(list!);

    emit(state.copyWith(uniformLocalImageSelected: photo, showImage2: xFile));
  }

  void onUniformVisitImageChange({XFile? xFile, CroppedFile? file}) async {
    final list = await file?.readAsBytes() ?? await xFile?.readAsBytes();
    final photo = base64Encode(list!);

    emit(state.copyWith(uniformVisitImageSelected: photo, showImage3: xFile));
  }

  void onCategoryChange(Category value) {
    //print("categoria seleccionada -----> ${category.categoryName}");
    //emit(state.copyWith(categorySelected: category));
    final categoryId = CategoryId.dirty(value.categoryId.toString());
    emit(state.copyWith(
        categoryId: categoryId,
        status: Formz.validate([categoryId, state.categoryId]),
        categorySelected: value));
  }

  void onTeamSelected(Team team) {
    print("categoria seleccionada -----> ${team.teamName}");
    emit(state.copyWith(
      teamInfo: team,
    ));
  }

  Future<void> getInfoManagers({required int personId}) async {
    print("Valor 1--------------------------------->");

    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await userRepository.getPersonDataByPersonId(personId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.loaded, errorMessage: l.message)), (r) {
      emit(state.copyWith(
        screenStatus: ScreenStatus.loaded,
        infoManager: r,
      ));
      print("Valor2---------------------------------> ${r.getFullName}");
    });
  }

  Future<void> createRefereeTeam() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
        screenStatus: ScreenStatus.loading));
    final user = User(
        userName: state.verificationSender.value,
        password: "Welcome1",
        person: Person.buildPerson(
            firstName: state.refereeName.value,
            lastName: state.refereeLastName.value,
            areaCode: 'LF',
            phone: state.getVerificationType() == VerificationType.phone
                ? state.verificationSender.value
                : null,
            email: state.getVerificationType() == VerificationType.email
                ? state.verificationSender.value
                : null),
        applicationRol: ApplicationRol.teamManager);
    final signUpResponse = await _repository.signUp(user);
    signUpResponse.fold(
        (l) => emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: l.message)), (r) {
      createTeam(r);
    });
  }

  Future<void> createTeam(User user) async {
    print("valor 3");
    CreateTeamDTO createTeam = CreateTeamDTO(
        teamName: state.teamName.value,
        categoryId: state.categorySelected.categoryId,
        leageAuxId: _authenticationBloc.state.leagueManager.leagueId,
        teamPhothoImage: state.photoTeamSelected,
        logoImage: state.photoTeamSelected,
        uniformLocalImage: state.uniformLocalImageSelected,
        uniformVisitImage: state.uniformVisitImageSelected,
        firstManagerId: user.person.personId);
    final response = await _service.createTeam(createTeam);

    response.fold(
        (l) => emit(
              state.copyWith(
                  status: FormzStatus.submissionFailure,
                  errorMessage: l.errorMessage),
            ), (r) {
      print("valor 3");
      emit(state.copyWith(
        screenStatus: ScreenStatus.createdSucces,
        status: FormzStatus.submissionSuccess,
      ));
    });
    page == 0;
    await getTeams(leagueId);
  }

  Future<void> deleteTeam(int teamId) async {
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading,
    ));
    print("Equipo a eliminar-------->${teamId}");
    final response = await _service.deleteTeamPresiden(teamId);

    response.fold(
        (l) => emit(
              state.copyWith(
                  status: FormzStatus.submissionFailure,
                  errorMessage: l.errorMessage),
            ), (r) {
      print("valor 3");
      emit(state.copyWith(
        screenStatus: ScreenStatus.deleteSucces,
      ));
    });
    page == 0;
    await getTeams(leagueId);
  }

  Future<void> updateTeam(Team team) async {
    print("valor 3");
    CreateTeamDTO updateTeam = CreateTeamDTO(
        teamId: team.teamId,
        teamName: state.teamName.value,
        categoryId:
            state.categorySelected.categoryId ?? team.categoryId!.categoryId!,
        leageAuxId: _authenticationBloc.state.leagueManager.leagueId,
        teamPhothoImage: team.logoId?.document != state.photoTeamSelected
            ? state.photoTeamSelected
            : team.logoId?.document,
        logoImage: team.logoId?.document != state.photoTeamSelected
            ? state.photoTeamSelected
            : team.logoId?.document,
        uniformLocalImage: state.uniformLocalImageSelected,
        uniformVisitImage: state.uniformVisitImageSelected,
        firstManagerId: team.firstManager);
    final response = await _service.updateTeam(updateTeam);

    response.fold(
        (l) => emit(
              state.copyWith(
                  status: FormzStatus.submissionFailure,
                  errorMessage: l.errorMessage),
            ), (r) {
      print("valor 3");
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        screenStatus: ScreenStatus.updateSucces,
      ));
    });
    page == 0;
    await getTeams(leagueId);
  }
}
