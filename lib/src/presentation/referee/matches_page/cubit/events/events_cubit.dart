import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_event.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/service/i_match_event_service.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/util/event_util.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_eliminatory_dto/qualifying_match_detail_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/end_match/end_match_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_detail/match_detail_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_event/match_event_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/referee_match.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/service/i_matches_service.dart';
import 'package:ligas_futbol_flutter/src/domain/player/dto/player_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/player/service/i_player_service.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/validators/minut.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/validators/player.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/validators/type_event.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/validators/type_match_team.dart';

import '../../../../../domain/tournament/entity/tournament.dart';
import '../../../../../domain/tournament/service/i_tournament_service.dart';

part 'events_state.dart';

@injectable
class EventsCubit extends Cubit<EventsState> {
  EventsCubit(
    this._matchesService,
    this._matchEventService,
    this._iPlayerService,
    this._tournamentService,
  ) : super(const EventsState());

  final IMatchesService _matchesService;
  final IMatchEventService _matchEventService;
  final IPlayerService _iPlayerService;
  final ITournamentService _tournamentService;
// # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
// ? Formulario
// # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  Future<void> onLoadingMatchEvents({required RefereeMatchDTO match}) async {
    getListEvents();
    getMatchDetail(match: match);

    if (match.jornada == 0) {
      getDetailEliminatory(matchId: match.matchId ?? 0);
    }
  }

  Future<void> getMatchDetail({required RefereeMatchDTO match}) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));

    final request = await _matchesService.getMatchDetail(match.matchId ?? 0);

    request.fold(
      (l) {
        emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage));
      },
      (r) {
        emit(state.copyWith(
          screenState: BasicCubitScreenState.loaded,
          matchDetail: r,
        ));
        getListPlayers(teamId: match.teamIdLocal!);
        getTournamentDetail(tournamentId: match.tournamentId!);
      },
    );
  }

  Future<void> getListPlayers({required int teamId}) async {
    emit(state.copyWith(
      teamIdSelected: teamId,
      playerValidator: const Player.pure(),
      loaderPlayers: Loaders.loadingPlayers,
    ));

    final response = await _iPlayerService.getTeamPlayers(teamId);

    response.fold(
      (l) {
        emit(state.copyWith(loaderPlayers: Loaders.error));
      },
      (r) {
        print('> succes >');
        r.isEmpty
            ? r.add(const PlayerDTO(
                fullName: 'No hay jugadores...',
                partyId: 0,
                playerId: 0,
                teamName: 'No hay jugadores...',
              ))
            : r.add(const PlayerDTO(
                fullName: 'Seleccionar jugador',
                partyId: 0,
                playerId: 0,
                teamName: 'Seleccionar jugador',
              ));

        r.sort((a, b) => a.partyId!.compareTo(b.partyId!));

        print('resultado modificado en getListPlayers : $r');

        emit(state.copyWith(
          playersList: r,
          playerSelected: r.first,
          playerValidator: Player.dirty('${r.first.playerId}'),
          loaderPlayers: Loaders.playersLoaded,
        ));
      },
    );
  }

  Future<void> getListEvents() async {
    List<EventUtil> eventsList = [];

    emit(state.copyWith(
      loaderEvents: Loaders.loadingEvents,
      typeEventValidator: const TypeEvent.pure(),
    ));

    eventsList.add(const EventUtil(
      code: "0",
      label: "Seleccionar evento",
    ));

    eventsList.add(EventUtil(
      code: RefereeEventTypes.GOAL.name,
      label: "Gooool!!!",
    ));

    eventsList.add(EventUtil(
      code: RefereeEventTypes.BLUE_CARD.name,
      label: "Tarjeta azul",
    ));

    eventsList.add(EventUtil(
      code: RefereeEventTypes.YELLOW_CARD.name,
      label: "Tarjeta amarilla",
    ));

    eventsList.add(EventUtil(
      code: RefereeEventTypes.RED_CARD.name,
      label: "Tarjeta roja",
    ));

    // TODO: pendiente
    // eventsList.add(EventUtil(
    //   code: RefereeEventTypes.CHANGE_PLAYER.name,
    //   label: "Cambio de jugador",
    // ));

    eventsList.add(EventUtil(
      code: RefereeEventTypes.FOUL.name,
      label: "Falta",
    ));

    // TODO: pendiente
    // eventsList.add(EventUtil(
    //   code: RefereeEventTypes.SUSPENSION.name,
    //   label: "Suspención",
    // ));

    emit(state.copyWith(
      loaderEvents: Loaders.eventLoaded,
      eventUtilSelected: eventsList[0],
      typeEventValidator: TypeEvent.dirty(eventsList[0].code!),
      eventsList: eventsList,
    ));
  }

  Future<void> onTypeMatchTeamChange({
    required TypeMatchTem type,
    int? teamId,
  }) async {
    emit(state.copyWith(typeMatchTeamValidator: const TypeMatchTeam.pure()));
    emit(state.copyWith(
      typeMatchTeamValidator: TypeMatchTeam.dirty(type.toString()),
      typeMatchTeamSelected: type,
    ));

    getListPlayers(teamId: teamId ?? 0);
  }

  Future<void> onPlayerChange({
    required PlayerDTO player,
  }) async {
    final xPlayer = Player.dirty('${player.partyId}');

    emit(state.copyWith(
      playerValidator: const Player.pure(),
    ));

    print('${player.toJson()}');

    emit(state.copyWith(
      playerSelected: player,
      playerValidator: xPlayer,
    ));
  }

  Future<void> onEventTypeChange({
    required EventUtil event,
  }) async {
    final xEvent = TypeEvent.dirty(event.code ?? '');
    emit(state.copyWith(
      eventUtilSelected: event,
      typeEventValidator: xEvent,
    ));
  }

  Future<void> onMinChange({required String mins}) async {
    final xMinut = Minut.dirty(mins);
    emit(state.copyWith(
      minutValidator: xMinut,
    ));
  }

  Future<void> onPressSaveEvent() async {
    emit(state.copyWith(
      playerValidator: Player.dirty(state.playerValidator.value),
      typeEventValidator: TypeEvent.dirty(state.typeEventValidator.value),
      minutValidator: Minut.dirty(state.minutValidator.value),
    ));

    if (state.playerValidator.valid == true &&
        state.typeEventValidator.valid == true &&
        state.minutValidator.valid == true) {
      emit(state.copyWith(
        screenState: BasicCubitScreenState.loading,
      ));

      final response = await _matchEventService.createMatchEvent(MatchEventDTO(
        teamMatchId: state.typeMatchTeamSelected == TypeMatchTem.local
            ? state.matchDetail.teamMatchLocal
            : state.matchDetail.teamMatchVisit,
        partyId: int.tryParse(state.playerValidator.value),
        eventType: state.typeEventValidator.value,
        matchEventTime: int.tryParse(state.minutValidator.value),
        causalDescription: '',
        timeType: TimeType.MINUTE.name,
        partyId2: 0,
      ));

      response.fold((l) {
        emit(state.copyWith(
          screenState: BasicCubitScreenState.error,
          errorMessage: l.errorMessage,
        ));
      }, (r) {
        emit(state.copyWith(
            screenState: BasicCubitScreenState.success,
            formzStatus: FormzStatus.submissionSuccess,
            statusMessage: "2"));
      });
    }
  }

  Future<void> onPressGameOver({
    required RefereeMatchDTO match,
    required MatchDetailDTO matchDetail,
  }) async {
    EndMatchDTO endMatchDTO = EndMatchDTO(
      matchId: match.matchId,
      scoreLocal: state.matchDetail.scoreLocal,
      scoreShoutoutLocal: state.scoreShoutOutLocal,
      teamMatchLocal: state.matchDetail.teamMatchLocal,
      scoreVist: state.matchDetail.scoreVisit,
      scoreShoutoutVisit: state.scoreShoutOutVisit,
      teamMatchVisit: state.matchDetail.teamMatchVisit,
    );

    print("> onPressGameOver");
    print("> > > > > > > > > > > > > > > > > > >");
    print("> $endMatchDTO");
    print("> > > > > > > > > > > > > > > > > > >");

    emit(state.copyWith(
      screenState: BasicCubitScreenState.loading,
    ));

    final response = await _matchesService.endMatch(endMatchDTO);

    response.fold(
      (l) {
        print('error > $l');
        emit(state.copyWith(
          screenState: BasicCubitScreenState.error,
          errorMessage: l.errorMessage,
        ));
      },
      (r) {
        print('success > $response');
        emit(state.copyWith(
            screenState: BasicCubitScreenState.success, statusMessage: "3"));
      },
    );
  }

  void resetInputsAndForm() {
    emit(state.copyWith(
      matchDetail: MatchDetailDTO.empty,
      scoreShoutOutLocal: null,
      scoreShoutOutVisit: null,
      minutValidator: const Minut.pure(),
      formzStatus: FormzStatus.pure,
    ));
  }

  Future<void> increaseScore(TypeMatchTem typeTeam) async {
    int score;
    if (typeTeam == TypeMatchTem.local) {
      score = state.scoreShoutOutLocal;
      print('$score');
      score = score + 1;
      emit(state.copyWith(scoreShoutOutLocal: score));
    } else {
      score = state.scoreShoutOutVisit;
      score = score + 1;
      print('$score');
      emit(state.copyWith(scoreShoutOutVisit: score));
    }
  }

  Future<void> decreaseScore(TypeMatchTem typeTeam) async {
    int score;
    if (typeTeam == TypeMatchTem.local) {
      score = state.scoreShoutOutLocal;
      print('st local -->$score');
      if (score == 0) {
        return;
      } else {
        emit(state.copyWith(scoreShoutOutLocal: score - 1));
      }
    } else {
      score = state.scoreShoutOutVisit;
      print('st visitante --> $score');
      if (score == 0) {
        return;
      } else {
        emit(state.copyWith(scoreShoutOutVisit: score - 1));
      }
    }
  }

  Future<void> getTournamentDetail({required int tournamentId}) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response =
        await _tournamentService.detailTournamentPresident(tournamentId);
    response.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      print('torneo --> $r');
      emit(state.copyWith(
          screenState: BasicCubitScreenState.loaded, tournamentSelected: r));
    });
  }

  Future<void> getDetailEliminatory({required int matchId}) async {
    //emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response = await _matchesService.getDetailEliminatory(matchId);
    response.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      print('MATCH ELIMINATORY --> $r');
      emit(state.copyWith(
          screenState: BasicCubitScreenState.loaded, qualifyingMatchDetail: r));
    });
  }
// # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
}
