enum BasicCubitScreenState {
  initial,
  loading,
  loaded,
  error,
  success,
  sending,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
  emptyData,
  invalidData,
  validating,
}

enum LMRequestType { league, referee, tournament, dateChange, fieldOwner }

enum DaysEnum { lunes, martes, miercoles, jueves, viernes, sabado, domingo }

enum TypeMatchTem { local, vist }

enum PersonalDataSubmitAction { updatePersonName, updateEmail, updatePhone }

// ignore: constant_identifier_names
enum Rolesnm {
  PLAYER,
  LEAGUE_MANAGER,
  SUPER_ADMIN,
  REFEREE,
  REFEREE_MANAGER,
  TEAM_MANAGER,
  FIELD_OWNER,
}

// ignore: constant_identifier_names
enum RequestType {
  TEAM_TO_PLAYER,
  PLAYER_TO_TEAM,
  REFEREE_TO_PLEAGUE,
  PLEAGUE_TO_REFEREE,
// ignore: constant_identifier_names
  LEAGUE_TO_ADMIN,
  TEAM_TO_PLEAGUE,
  PLEAGUE_TO_TEAM,
  RELEASE_PLAYER_FROM_TEAM,
  EAM_TO_TOURNAMENT,
// ignore: constant_identifier_names
  TOURNAMENT_TO_TEAM,
  MATCH_TO_FIELD
}

enum RefereeEventTypes {
  GOAL,
  RED_CARD,
  BLUE_CARD,
  YELLOW_CARD,
  SUSPENSION,
  FOUL,
  CHANGE_PLAYER,
}

enum TimeUnitTypes {
  MINUTE,
  HOUR,
  SECOND,
  FOURTH,
  SET,
}

enum SortingOptions {
  byName('Alfabeticamente');
  //byDate('Por fecha');

  final String description;
  const SortingOptions(this.description);
}

enum LMTournamentScreen {
  initial,
  loadingCategories,
  loadingTournaments,
  loadingTable,
  loadingTableFilteredByRound,
  loadingTeamsTournament,
  categoriesLoaded,
  tournamentsLoaded,
  tableLoaded,
  creatingRoles,
  rolesCreatedSuccessfully,
  loadingTournamentStatus,
  tournamentStatusLoaded,
  loadingConfigLeague,
  configLeagueLoaded,
  loadingQualifiedTeams,
  qualifiedTeamsLoaded,
  loadingQualifyingMatchDetail,
  qualifyingMatchDetailLoaded,
  teamsTournamentLoaded,
  createdConfiguration,
  errorOnCreatingRoles,
  error,
}

enum Rounds {
  SEMIFINAL,
  CUARTOS,
  OCTAVOS,
  DIECISEISAVOS,
}

enum TieBreakerType {
  TABLEPOSITIONS,
  PENALTIESORSHOOTOUT,
}

enum MatchForRound {
  ONEMATCH,
  ROUNDTRIP,
}

enum UserPostType {
  TEAM_SEARCH_PLAYER,
  LEAGUE_SEARCH_REFEREE,
  PLAYERS_SEARCH_TEAM,
  REFEREE_SEARCH_LEAGUE
}

enum TypeTopic {
  PLAYER_TO_REFERE,
  PLAYER_TO_FIELD,
  REFEREE_TO_PLAYER,
  REFEREE_TO_TEAM,
  REFEREE_TO_FIELD,
  FIELD_TO_MATCH
}

enum RefereeEventType {
  yellowCard,
  redCard,
  all,
}
