part of 'events_cubit.dart';

enum Loaders {
  loadingPlayers,
  playersLoaded,
  loadingEvents,
  eventLoaded,
  error
}

class EventsState extends Equatable {
  // ? -- Data
  final MatchDetailDTO matchDetail;
  final int scoreShoutOutLocal;
  final int scoreShoutOutVisit;
  final List<RefereeMatchDTO> matches;
  final List<PlayerDTO> playersList;
  final List<EventUtil> eventsList;
  final Tournament tournamentSelected;
  final QualifyingMatchDetailDTO? qualifyingMatchDetail;
  // ? -- Inputs
  final int? teamIdSelected;
  final PlayerDTO? playerSelected;
  final EventUtil eventUtilSelected;
  final TypeMatchTem typeMatchTeamSelected;
  final TypeMatchTeam typeMatchTeamValidator;
  final Player playerValidator;
  final TypeEvent typeEventValidator;
  final Minut minutValidator;
  final FormzStatus formzStatus;
  // ? -- Basic
  final BasicCubitScreenState screenState;
  final String? errorMessage;
  // ? -- Loaders
  final Loaders loaderPlayers;
  final Loaders loaderEvents;
  final String statusMessage;

  const EventsState({
    this.matchDetail = MatchDetailDTO.empty,
    this.scoreShoutOutLocal = 0,
    this.scoreShoutOutVisit = 0,
    this.matches = const [],
    this.playersList = const [],
    this.eventsList = const [],
    this.tournamentSelected = Tournament.empty,
    this.qualifyingMatchDetail,
    this.teamIdSelected,
    this.playerSelected,
    this.eventUtilSelected = EventUtil.empty,
    this.typeMatchTeamSelected = TypeMatchTem.local,
    this.typeMatchTeamValidator = const TypeMatchTeam.pure(),
    this.playerValidator = const Player.pure(),
    this.typeEventValidator = const TypeEvent.pure(),
    this.minutValidator = const Minut.pure(),
    this.formzStatus = FormzStatus.pure,
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
    this.loaderPlayers = Loaders.loadingPlayers,
    this.loaderEvents = Loaders.loadingEvents,
    this.statusMessage = "",
  });

  EventsState copyWith({
    MatchDetailDTO? matchDetail,
    int? scoreShoutOutLocal,
    int? scoreShoutOutVisit,
    List<RefereeMatchDTO>? matches,
    List<PlayerDTO>? playersList,
    List<EventUtil>? eventsList,
    Tournament? tournamentSelected,
    QualifyingMatchDetailDTO? qualifyingMatchDetail,
    int? teamIdSelected,
    PlayerDTO? playerSelected,
    EventUtil? eventUtilSelected,
    TypeMatchTem? typeMatchTeamSelected,
    TypeMatchTeam? typeMatchTeamValidator,
    Player? playerValidator,
    TypeEvent? typeEventValidator,
    Minut? minutValidator,
    FormzStatus? formzStatus,
    Loaders? loaderPlayers,
    Loaders? loaderEvents,
    BasicCubitScreenState? screenState,
    String? errorMessage,
    String? statusMessage,
  }) {
    return EventsState(
        matchDetail: matchDetail ?? this.matchDetail,
        scoreShoutOutLocal: scoreShoutOutLocal ?? this.scoreShoutOutLocal,
        scoreShoutOutVisit: scoreShoutOutVisit ?? this.scoreShoutOutVisit,
        matches: matches ?? this.matches,
        playersList: playersList ?? this.playersList,
        eventsList: eventsList ?? this.eventsList,
        tournamentSelected: tournamentSelected ?? this.tournamentSelected,
        qualifyingMatchDetail:
            qualifyingMatchDetail ?? this.qualifyingMatchDetail,
        teamIdSelected: teamIdSelected ?? teamIdSelected,
        playerSelected: playerSelected ?? playerSelected,
        eventUtilSelected: eventUtilSelected ?? this.eventUtilSelected,
        typeMatchTeamSelected:
            typeMatchTeamSelected ?? this.typeMatchTeamSelected,
        typeMatchTeamValidator:
            typeMatchTeamValidator ?? this.typeMatchTeamValidator,
        playerValidator: playerValidator ?? this.playerValidator,
        typeEventValidator: typeEventValidator ?? this.typeEventValidator,
        minutValidator: minutValidator ?? this.minutValidator,
        formzStatus: formzStatus ?? this.formzStatus,
        screenState: screenState ?? this.screenState,
        errorMessage: errorMessage ?? this.errorMessage,
        loaderPlayers: loaderPlayers ?? this.loaderPlayers,
        loaderEvents: loaderEvents ?? this.loaderEvents,
        statusMessage: statusMessage ?? this.statusMessage);
  }

  @override
  List<Object?> get props => [
        matchDetail,
        scoreShoutOutLocal,
        scoreShoutOutVisit,
        screenState,
        matches,
        playersList,
        eventsList,
        tournamentSelected,
        qualifyingMatchDetail,
        teamIdSelected,
        playerSelected,
        eventUtilSelected,
        typeMatchTeamSelected,
        typeMatchTeamValidator,
        playerValidator,
        minutValidator,
        formzStatus,
        loaderPlayers,
        loaderEvents,
        statusMessage
      ];
}
