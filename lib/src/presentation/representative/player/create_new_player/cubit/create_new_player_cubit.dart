import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/dto/create_team_player_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/service/i_team_player_service.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../core/enums.dart';
import '../../../../../domain/player/service/i_player_service.dart';
import '../../../../../domain/referee/referee_last_name.dart';
import '../../../../../domain/referee/referee_name.dart';
import '../../../../../domain/sign_up/models.dart';
import '../../../../../domain/team/entity/team.dart';
import '../../../../../domain/team_player/entity/team_player.dart';

part 'create_new_player_state.dart';

@injectable
class CreateNewPlayerCubit extends Cubit<CreateNewPlayerState> {
  CreateNewPlayerCubit(
    this._authenticationRepository,
    this._playerService,
    this._teamPlayerService,
  ) : super(const CreateNewPlayerState());

  final AuthenticationRepository _authenticationRepository;
  final IPlayerService _playerService;
  final ITeamPlayerService _teamPlayerService;

  void onChangePlayerName(String value) {
    final playerName = RefereeName.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          playerName,
          state.playerName,
          state.verificationSender,
        ]),
        playerName: playerName));
  }

  void onChangePlayerLastName(String value) {
    final playerLastName = RefereeLastName.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          playerLastName,
          state.verificationSender,
          state.playerName,
        ]),
        playerLastName: playerLastName));
  }

  void onVerificationSenderChanged(String value) {
    final verificationSender = VerificationSender.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          verificationSender,
          state.playerLastName,
          state.playerName,
        ]),
        verificationSender: verificationSender));
  }

  Future<void> createNewPlayerTeam(
      {required int teamId, required int partyId}) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final user = User(
        userName: state.verificationSender.value,
        password: "Welcome1",
        person: Person.buildPerson(
            firstName: state.playerName.value,
            lastName: state.playerLastName.value,
            areaCode: 'LF',
            phone: state.getVerificationType() == VerificationType.phone
                ? state.verificationSender.value
                : null,
            email: state.getVerificationType() == VerificationType.email
                ? state.verificationSender.value
                : null),
        applicationRol: ApplicationRol.player);

    final signUpResponse = await _authenticationRepository.signUp(user);
    signUpResponse.fold(
        (l) => emit(state.copyWith(
            status: FormzStatus.submissionFailure, errorMessage: l.message)),
        (r) => {
              emit(state.copyWith(infoUser: r)),
              createPlayer(teamId: teamId),
              //getTeamPlayer(partyId: partyId, teamId: teamId),
            });
    //getTeamPlayer(partyId: partyId, teamId: teamId);
  }

  Future<void> createPlayer({required int teamId}) async {
    Player player = Player(partyId: state.infoUser.person.personId);
    final request = await _playerService.savePlayer(player);
    request.fold(
        (l) => emit(state.copyWith(errorMessage: l.errorMessage)),
        (r) => {
              emit(state.copyWith(
                infoPlayer: r,
              )),
              createRelationTeamPlayer(teamId: teamId),
            });
  }

  void resetInputsAndForm() {
    emit(state.copyWith(
      playerName: const RefereeName.pure(),
      playerLastName: const RefereeLastName.pure(),
      verificationSender: const VerificationSender.pure(),
      status: FormzStatus.pure,
    ));
  }

  Future<void> createRelationTeamPlayer({required int teamId}) async {
    Team team = Team(teamId: teamId);

    CreateTeamPlayerDTO teamPlayer = CreateTeamPlayerDTO(
      playerId: state.infoPlayer,
      teamId: team,
      registerPhotoId: null,
      numberApprovalFlag: '',
      playerPosition: 0,
      playerNumber: 0,
      punishmentMatches: 0,
    );
    final response = await _teamPlayerService.createTeamPlayer(teamPlayer);
    response.fold(
        (l) => emit(
              state.copyWith(
                  status: FormzStatus.submissionFailure,
                  errorMessage: l.errorMessage),
            ), (r) {
      resetInputsAndForm();
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
      ));
    });
    emit(state.copyWith(
      status: FormzStatus.pure,
    ));
  }

  Future<void> getTeamPlayer(
      {required int partyId, required int teamId}) async {
    final response = await _teamPlayerService.getTeamPlayer(partyId, teamId);
    response.fold(
        (l) => {
              emit(state.copyWith(errorMessage: l.errorMessage)),
            }, (r) {
      emit(state.copyWith(teamPlayer: r));
    });
  }
}
