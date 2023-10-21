import 'package:ligas_futbol_flutter/environment_config.dart';

const String _apiBasePath = '/iaas/api/v1';

/// Endpoint to get a list of all the available roles of an organization
/// Requires orgId
///
/// METHOD GET
String get getRolesByOrgIdEndpoint =>
    '${EnvironmentConfig.personManagementBaseURL}$_apiBasePath/rol/get/all';

/// Endpoint to get data player by id
String get getDataPlayerByIdEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/player/dataProfile';

/// Endpoint to get data validated reuquest by playerid and teamid
String get getValidationRequest =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/playervalidate/request';

///Endpoint to update a date player
String get getUpdatePlayerEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/player';

/// Endpont to get search players to teams
String get getSearchPlayerEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/player/searchplayer';

/// Endpoint to get all leagues
String get getAllLeaguesEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/leagues';

String get leagueBaseEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/league';

String get getLeagueByIdEndpoint =>
    '${EnvironmentConfig.personManagementBaseURL}$_apiBasePath/leagues';

String get getTournamentEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/tournamets';

String get getFindByNameAndCategoryEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/tournamets/findByNameAndCategory';

String get getCategoryByTournamentByAndLeagueIdEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/category';

String get getMatchesByTournamentEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/matchs/rols';

String get getScoringTournamentIdEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/team/tournament/notPPS';

String get getGoalsTournamentIdEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/scroring/tournament';

String get getRequestTeamByLeagueEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/teams/requestplayer';

String get teamServiceTeamsEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/teams';

/// Endpoint to get data Request By Status And Type
String get getRequestByStatusAndTypeEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/lookupValue/requestByStatusAndType';

/// Endpoint to get data RequestLeagueToAdmin
String get requestBaseEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request';

/// Endpoint to get data RequestLeagueToAdmin
String get getRequestLeagueToAdminEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestLeagueToAdmin';

String get getRequestFieldToAdminEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestFieldToAdmin';

/// Endpoint to get data RequestLeagueToReferee
String get getRequestLeagueToRefereeEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestLeagueToReferee';

String get sendRequestForFieldAdminEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/fieldToAdmin';

/// Endpoint to get data RequestPlayerToTeam
String get getRequestPlayerToTeamEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestPlayerToTeam';

/// Endpoint to get data RequestPlayerToTeam
String get requestPlayerToTeamEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/request/playerToTeam';

/// Endpoint to get data RequestPlayerToTeam
String get requestTeamToPlayerEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/request/teamToPlayer';

/// Endpoint to get data RequestRefereeToLeague
String get getRequestRefereeToLeagueEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestRefereeToLeague';

String get getRequestTeamToTournamentEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestTeamToTournament';

String get getRequestTournamentToTeamEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestTournamentToTeam';

/// Endpoint to get data RequestTeamToPlayer
String get getRequestTeamToPlayerEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestTeamToPlayer';
String get getUserDeleteRequestEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestDeletePLayers';

String get getDeleteLeaguesRequestsEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestToDeleteLeagues';

/// Endpoint to cancelRequest
String get cancelRequestEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/cancelRequest';

String get getsAllTeamsPlayerEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/teams/party';

String get getMatchesByPlayerEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/matchs/mymatches';

String get getDetailMatchByPlayerEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/matchs/detailMatch';

String get getAllExperiencesByPlayerEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/experiences';

/// Endpoint to get a list of all the available for users
/// Requires userId
///
/// METHOD GET
String get getAvailableRolesForUserEndpoint =>
    '${EnvironmentConfig.personManagementBaseURL}$_apiBasePath/user/configuration/get/available/roles';

/// Endpoint to get a list of all the roles associated with one user
/// Requires userId
///
/// METHOD GET
String get getRolesAssociatedToUserEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/user/configuration/get/user/roles';

/// Endpoint to manage user configuration data
///
/// METHOD POST, PATCH, DELETE
String get getUserConfigurationEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/userconfiguration';

/// Endpoint to get user configuration data
/// Requires userId
///
/// METHOD GET
String get getUserConfigurationDataEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/configuration/get/user/data';

String get userRolEndpoint =>
    '${EnvironmentConfig.personManagementBaseURL}$_apiBasePath/userRol';

String get updatePrimaryRolEndpoint =>
    '${EnvironmentConfig.personManagementBaseURL}$_apiBasePath/userRol/change/primary';

String get getUserRolesEndpoint =>
    '${EnvironmentConfig.personManagementBaseURL}$_apiBasePath/user/rol/associated/get';

String get getTeamPlayerEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/player/teamMate';

String get getTransferHistoryPlayerEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/teams/transferHistoryPlayer';

String get postRecommendationsEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/recommendation/playerForTeam';

String get getRecomendationsByTeamEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/recommendation/recommendedplayer/';

String get responseRecomendationEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/recommendation/responserecomendation/';

String get getAllTeamsEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/teams/allTeams';

String get getAllPagedTeamsEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/all/team';

String get getAllPagedTeamsByLeagueEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/team/teamspageableByLeague';

String get getTeamsLeagueIdEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/team/teamsByLeague';

String get getTournamentByPlayerEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/tournament/tournamentByPlayer';

String get getPerformanceByPlayerEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/teamsPlayer/stattics/tournament';

String get updateRequestEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/request/responseRequest';

String get playerExperienceEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/experiences';

//?--------->PRESIDENTE DE LIGA<--------?

//get all tournaments by leagueid leage
/// * {require league id}
String get getTournamentsByLeaguePresident =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/tournamets/league/';

//field path
String _fieldPath = "${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/field";

/// Create a field
///
/// * @param [Field]
///
/// METODH POST
String get createFieldPresident => _fieldPath;

/// get all fields by leage id all/{require league id}
///
/// * @param [leagueId]
///
///METODH GET
String get getFieldByLeaguePresident => '$_fieldPath/all/';

/// get field by name
///
/// * @param [nameField]
///
/// METHODH GET
String get getFieldName => '$_fieldPath/all/name/';

/// get field by id
///
/// * @param [fieldId]
///
/// METHODH GET
String get getFieldById => '$_fieldPath/findById/';

//?-----CATEGORY----?
String _categoryPathPresident =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/category';

/// Get a category by league id {require league id}
///
/// * @param [leagueId]
///
/// METODH GET
String get getCategoryByLeagueIdPresident =>
    '$_categoryPathPresident/categoryByLeagueId/';

///
/// Create a category
///
/// * @param [Category]
///
/// METODH POST
String get createCategoryPresident => _categoryPathPresident;

///
/// Find category by category id
///
/// * @param [categoryId]
///
/// METODH GET
String get getCategoryByCategoryIdPresident =>
    '$_categoryPathPresident/findcategoryID/';

///
/// Delete a gateccory by id
///
/// * @param [categoryId]
///
/// METODH DELETE
String get deleteCatecoryByIdPresident => '$_categoryPathPresident/delete/';

///
/// Update a category
///
/// * @param [Category]
///
/// METODH PATCH
String get updateCategoryPresident => _categoryPathPresident;

//?-----TEAM----?
String _teamPresidentPath =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/team';

///
/// Get a list of all teams
///
/// METODH GET
String get getAllteamsPresident => '$_teamPresidentPath/all';

///
/// Create a team
///
/// * @param [Team]
///
///METODH POST
String get createTeamPresident => _teamPresidentPath;

///
/// Update a team
/// * @param [Team]
///
/// METODH PATCH
String get updateTeamPresident => _teamPresidentPath;

///
/// Detail team
/// * @param [teamId]
/// METODH GET
String get getDetailTeamPresident => '$_teamPresidentPath/';

///
/// get teams by category
///
/// * @param [categoryId]
///
/// METODH GET
String get getTeamByCategoryPresident => '$_teamPresidentPath/categorie/';

///
/// Delete team
///
/// * @param [teamid]
///
/// METODH DELETE
String get deleteTeamPresident => '$_teamPresidentPath/delete/';

//?----Tournaments----?
String _tournamentsPresidentPath =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/tournamets';

///
/// Get tournaments by category
///
/// * @param [categoryId]
///
/// METODH GET
String get getTournamentsByCategoryPresident =>
    '$_tournamentsPresidentPath/findByCategory/';

///
/// Create a tourament
///
/// * @param [Tournament]
///
/// METODH POST
String get createTournamentPresiden => _tournamentsPresidentPath;

///
/// Update a tournament
///
/// * @param [Tournament]
///
/// METODH PATCH
String get updateTournamentPresident => _tournamentsPresidentPath;

///
/// Get tournament detail
/// * @param [tournamentId]
///
///METODH GET
String get getTournamentDetailPresident =>
    '$_tournamentsPresidentPath/findById/';

///
/// Delete tournament
/// * @param tournamentId
///
///METODH DELETE
String get deleteTournamentPresiden => '$_tournamentsPresidentPath/delete/';

//?---teamTournament---?
String _teamTournamentPresidentPath =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/teamTournament';

///
/// teams by tournament
///
/// * @param [tournamentId]
///
///METODH GET
String get getTeamTournamentsByTournamentId => '$_teamTournamentPresidentPath/';

///
/// teams by tournament
///
/// * @param [tournamentId]
///
///METODH GET
String get getTeamClassifiedByTournamentId =>
    '$_teamPresidentPath/teamsclassified';

///
/// * register teams on a tournament
///
///METODH POST
String get registerTeamOnTournamet => _teamTournamentPresidentPath;

///
/// teams by tournament
///
/// * @param [teamTournamentId]
///
///METODH DELETE
String get getUnsubscribeTeamsTournament => '$_teamTournamentPresidentPath/';

///
/// teams by tournament
///
/// * @param [teamTournamentId]
///
///METODH DELETE
String get getTournamentTeamDataBytournamentId =>
    '$_teamTournamentPresidentPath/detailteamtournaments/';

///
/// * get teams subscribed on a tournament
///*/teamTournamentcountTeamsTournament/
///METODH get
String get getCountTeamOnTournametRegister =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/teamTournamentcountTeamsTournament/';

///
/// * get all team tournaments
/// @param [teamId]
/// * METODH get
String get getTeamTournaments =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/tournament/tournamentByTeam/';

///
/// * get all tournaments by team and league
/// @param[teamId, leagueId]
/// * METODH get
String get getTournamentsByTeamAndLeague =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/tournament/searchTournament/';

///
/// * submit tournament request
///
/// * METODH post
String get sendRequestTournamentRegistration =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/request/sendRequestTournemantTeam/';

///
/// * get all tournaments invitations by team
///
/// * METODH get
String get getTournamentsInvitationsByTeam =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/request/tournementTeam/';

///
/// * get all tournaments invitations by team
///
/// * METODH get
String get sendResponseToTournamentInvitation =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/request/responseRequest/';

///
/// * get data of general table by tournament
///
/// * METODH get
String get getGeneralTableByTournamentId =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/team/tournament/';

//?----Game Roles----?

///
/// Get role game
///
/// * @param tournamentId
///
///METODH GET
String get getRoleGamePresident =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/matchs/rols/';

///
/// Create new game roles update automatic
///
///* @param [tournamentId]
///
///METODH POST
String get createRoleGameAutoPresident =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/matche/rols/';

///
/// Edit scoring system
///
/// METODH PATCH
String get updateScoringSystemPresident =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/scoringSystem';

///
/// Create scoring system
///
/// METODH POST
String get createScoringSystemPresident =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/scoringSystem';

///
/// Get scoring sstem by leage
///
/// * @param [leagueId]
///
/// METODH GET
String get getScoringSystemsPresident =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/scoringSystem/forLeague/';

///
/// Get scoring sstem by leage
///
/// * @param [leagueId]
///
/// METODH GET
String get getScoringSystemTournamnetPresident =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/scoringSystem/tournament/';

///
/// Get detail by match
///
/// * @param [roundNumber]
///
/// METODH GET
String get getMatchDetailByTorunament =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/matchs/detailByRols/';

///
/// Get round number and matches pending
///
/// * @param [tournamentId]
///
/// METODH GET
String get getMatchPendingByRoundNumber =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/matchs/matchPendingByRoundNumber/';

///
/// End point to finalize match
///
/// * @param [FinalizeMatchDTO]
///
/// METODH PATCH
String get getFinalizeMatchPresident =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/matchs/endMatch';

///
/// End point to edit match
///
/// * @param [EditMatchDTO]
///
/// METODH PATCH
String get getUpdateMatcDTOPresident =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/matchs/configmach';

///
/// End point to delete match
///
/// * @param [matchId]
///
/// METODH PATCH
String get getDeleteMatch =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/matche/delete/';

///
/// End point to get next round
///
/// * @param [tournamentId]
///
/// METODH GET
String get getNextRoundNumber =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/matchs/nextRoundNumber/';

///
/// End point to get next round
///
/// * @param [List objects of MatchRoleDTO]
///
/// METODH POST
String get getCreateEditRols =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/match/creatematcheditrol';

/// METODH POST
String get getCreateRolsC =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/match/createMatchLeague';

//?---- President requests ---?

/// Request general endpoint
String _requestPresidentPath =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request';

///
/// Get requests to league
///
///METODH GET
String get getRequestToLeague => '$_requestPresidentPath/leagueToAdmin';

///
/// Get request from refreee
///
/// * @param query param need [{?leagueId,refereeId}]
///
/// METODH GET
String get getRequestFromReferee =>
    '$_requestPresidentPath/requestLeagueToReferee';

///
/// Get request send to refree
///
/// * @param query param need [{?leagueId,refereeId}]
///
/// METODH GET
String get getRequestSendToRefree =>
    '$_requestPresidentPath/requestRefereeToLeague';

/*START HERE TO*/
///
/// Get statics by category id
///
///* @param [categoryId]
///
///METHOD GET
String get staticsPlayerByCategoryEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/category/statictsPlayerbycategory';

///
/// Get referee by league
///
///* @param [leagueId]
///
///METHOD GET
String get refereeByLeagueEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/referee/refereeByLeague';

///
/// Get referee search
///
///* @param [leagueId]
///
///METHOD GET
String get searchRefereeEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/referee/refereeSearch';

///
/// Referee endpoint
///
///METHOD POST
String get refereeEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/referee';

///
/// Referee endpoint
///
///METHOD PATCH
String get updateRefereeEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/referee';

///
/// Get referee detail
///
///* @param [refereeId]
///
///METHOD GET
String get detailRefereeEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/referee/detailReferee';

///
/// Get referee matches by referee id
///
///* @param [refereeId]
///
///METHOD GET
String get refereeMatchesEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/referee/myMatches';

///
/// Get referee rating by referee id
///
///* @param [refereeId]
///
///METHOD GET
String get ratingByRefereeEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/referee/ratingByReferee';

///
/// Get historic tournaments by category id
///
///* @param [categoryId]
///
///METHOD GET
String get historicTournamentsEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/tournamets/historicTournaments';

///
/// Get players by team
///
///* @param [teamId]
///
///METHOD GET
String get playersByTeamEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/teamsPlayer/playersByTeam';

///
/// Delete team player
///
///* @param [teamPLayerId]
///
///METHOD DELETE
String get deleteTeamPlayerEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/teamsPlayer/delete';

//?---Look Up Values---?
String lookUpvaluePatchAdmin =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/lookupValue';

///
/// Get all lookupvalues filtered by lookupType
///
///* @param [lookupType]
///
///METHOD GET
String get getLookUpValuesByLookupType => '$lookUpvaluePatchAdmin/allTypes/';

///
/// Get all lookupvalues filtered by lookupType and lookupName
///
///* @param [lookupType , lookupName]
///
///METHOD GET
String get getLookUpValuesByLookupTypeAndName =>
    '$lookUpvaluePatchAdmin/allTypesByName';

///
/// Get manager leagues
///
///* @param [personId]
///
///METHOD GET
String get getManagerLeaguesEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/league/findbypresidend';

//?----------Teams President-----------?

String teamsPresidentPath =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/team';
//String teamsPresidentPath = '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/team';

///
/// Get team by id pamc
///
///* @param [teamId]
///
///METHOD GET
String get getTeamByTeamId => teamsPresidentPath;

///
/// Get teams not suscribed on tournament
///
///* @param [tournamentId]
///
///METHOD GET
String get getTeamsToSuscribe => '$teamsPresidentPath/teamssubs';

///
/// Get teams not suscribed on tournament
///
///* @param [tournamentId]
///
///METHOD GET
String get getTeamsSuscribed => '$teamsPresidentPath/teamssubs';

///
/// Get manager leagues
///
///* @param [categoryId]
///
///METHOD GET
String get getCurrentTournamentEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/tournamets/currentTournament/';

/// Endpoint to send referee request to league
String get sendRequestRefereeToLeagueEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/refereeToLeague';

/// Endpoint to send request
String get sendRequest =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/leagueToReferee';

/// Endpoint to send referee request to league
String get sendNewRequestRefereeToLeagueEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestnewRoll/referee';

/// Endpoint to send referee request to league
String get getRefereeLeaguesEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/referee/leagueByReferee';

/// Endpoint to send referee request to league
String get getRefereeDataByPersonIdEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/referee/refereeData';

String get getTeamsFindByRepresentantEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/teams/findByRepresentant';

String get getMatchesByTeamEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/teams/matcheByTeam';
//?----Matchs-----?//
String get getRefereeMatchesEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/matchesReferee/myMatchesReferee';
String get getMatchesRefereeStatsEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/matchesReferee/myMatchesReferee/statics';
String get getRefereeMatchDetailsEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/matches/detailRef/';
String get startMatchEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/matches/start/';
String get endMatchEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/matchs/endMatch';
//?----Matchs Events-----?//
String get crtMatchEventEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/matchEvent';

String get getHistoricRefereeMatchesEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/matchesReferee/historyReferee';

String get getCalendaraRefereeMatchesEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/matchesReferee/calendarReferee';

String get getFieldByMatchIdEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/field';

String get getFieldRentEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/field/searchFieldByFilters';

String get getFieldRentNFEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/field/fieldsRent';

//?----Scoring table-----?//

String _scoringTablePathAdmin =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/scoringtable';

///Get scoring table data
///
/// *@param [tournamentId]
///
/// METODH GET
String get getScoringTableData => '$_scoringTablePathAdmin/data/';

///Insert scoring table data
///
/// *@param [ScotingTable] obj
///
/// METODH POST
String get getCreateScoringTableData => _scoringTablePathAdmin;

//?---- Player ----?//
String _playersAdminPath =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/player';

String getTeamPlayersEndpoint =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/player/team/';

///Get playes into team with dto
///
/// *@param [teamId]
///
/// /// METODH POST
String get createPlayer => _playersAdminPath;

/// METODH GET
String get getPlayesInTeamAdmin => '$_playersAdminPath/team/';

/// Endpoint to get data RequestRefereeToLeague
String get getRequestTeamToLeagueEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestTeamToLeague';

String get updateAdminRequestEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/responseRequest';

String get getRefereeStaticsEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/referee/statictsReferee';

String get getTournamentEventCountEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/referee/countEventsTournaments';

String get getUserConfigurationByUserRolIdEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/configuration/data';

/// Endpoint request new rol
String get _requestNewRollPath =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/requestnewRoll';

String get createRequesNewTeamEndpoint => '$_requestNewRollPath/team';

String get getNotificationCountEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/request/count';

String get createTeamPlayerEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/teamplayer';

//?---Uniforms---?
String uniformAdminPath =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/uniform/';

String getUniformsEndpoint = '${uniformAdminPath}dto/team/';

String saveUniformEndpoint = '${uniformAdminPath}savedto';

String get getRefereeAvailabilityEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/referee/avialability';

String get getRefereeAvailabilityQAEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/referee/worksdays/avialability';

String get getFieldsEventsEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/fields/avialability/events';

String get getRefereeEventsEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/referee/events/referee';

String get getRefereeAgendaEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/referee/worksdays/avialability';

String get getUpdateRolSPR =>
    '${EnvironmentConfig.personManagementBaseURL}$_apiBasePath/userRolUp/spr';

String get createAvailabilityEndpoint =>
    '${EnvironmentConfig.qraEventsBaseURL}$_apiBasePath/availability';

String get createRefereeScheduleEndpoint =>
    '${EnvironmentConfig.qraEventsBaseURL}$_apiBasePath/assets/refereesSchedule';

String get qraEventEndpoint =>
    '${EnvironmentConfig.qraEventsBaseURL}$_apiBasePath/events';

String get qraPricesEndpoint =>
    '${EnvironmentConfig.qraEventsBaseURL}$_apiBasePath/prices';

String get qraDeletePriceEndpoint => '$qraPricesEndpoint/deletePrice/';

String get createQraFieldLeagueEndpoint =>
    '${EnvironmentConfig.qraEventsBaseURL}$_apiBasePath/assets/fieldsleague';

String get getAvailabilityFieldEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/fields/avialability';

String get createMatchEventEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/matchEvent';

String get getMatchEventsRefereeEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/matchEvent/teamMatchId';

String get getMatchEventsRefereeEndpointAll =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/matchEvent/matchId';

String get getFieldOwnerRequestEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/request/requestOwnes';

String get acceptFieldOwnerRequestEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/request/responseRequest';

String getRentalFieldsEndpoint =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/field/fieldsRent';

String updateMatchDateEndpoint =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/matchs/configmach';

String updateMatchFieldEndpoint =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/match/updateField';

String updateMatchRefereeEndpoint =
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/match/updateRefereeMatch';

String get getRequestMatchToRefereeEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/request/requestMatchToReferee';

String get sendRefereeResponseRequestEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/request/responseRequest';

String get getAllMyAssetsEndpoint =>
    '${EnvironmentConfig.qraEventsBaseURL}$_apiBasePath/prices/allbyactiveid';

String get createPriceEndpoint =>
    '${EnvironmentConfig.qraEventsBaseURL}$_apiBasePath/prices';

String get deletePriceEndpoint =>
    '${EnvironmentConfig.qraEventsBaseURL}$_apiBasePath/prices/deletePrice';

String get getTournamentChampionEndpoint =>
    '$_tournamentsPresidentPath/tournamentChampion';

String get tournamentFinishedEndpoint =>
    '$_tournamentsPresidentPath/tournamentFinished';

String get getTournamentMatchesStatusEndpoint =>
    '$_tournamentsPresidentPath/tournamentMatchesFinishedStatus';

String get addressesEndpoint =>
    '${EnvironmentConfig.qraEventsBaseURL}$_apiBasePath/addresses';
String get configLeagueEndpoint => '$_tournamentsPresidentPath/configLeague';

String get inscribeLeagueTeamsEndpoint =>
    '$_teamTournamentPresidentPath/inscribeLeagueTeasms';

String get getQualifiedTeamsEndpoint => '$_teamPresidentPath/teamsclassified';

String get getRefereeByAddressEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/referee/searchByFilters';

String get getDetailEliminatoryEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/matches/detailEliminatory';

String get userPostEndpoint =>
    '${EnvironmentConfig.sprTeamPlayerBaseURL}$_apiBasePath/posts';

String get getUserPostByTournamentEndpoint =>
    '$userPostEndpoint/getPostByTournament';

String get deleteUserPostEndpoint => '$userPostEndpoint/deletePost';

String get getUserPostByPostIdEndpoint => '$userPostEndpoint/getPostById';

String get getUserPostByAuthorAndTypeEndpoint =>
    '$userPostEndpoint/getPostByMadeByAndType';

String get topicsEvaluation =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/topicEvaluation';

String get qualificationToTopics =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/qualificationToTopics';

String get getTopicsEvaluationEndpoint => '$topicsEvaluation/getByType';

String get saveQualifications =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/qualifications';

String get getQualificationToTopics => '$qualificationToTopics/';

String get qualificationTopicsEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/qualificationToTopics';

String get getDetailevaluated =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/qualificationToTopics/getDetailevaluated';

String get getExistQualificationEndpoint =>
    '$qualificationToTopics/existQualification';

String get getMatchByEventId =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/matches/matchByEvent/';

String get deactivateAccountEndpoint =>
    '${EnvironmentConfig.personManagementBaseURL}$_apiBasePath/users/deactivateUser';

String get deleteAccountEndpoint =>
    '${EnvironmentConfig.sprAdminBaseURL}$_apiBasePath/admin/player/delete';

String get getRefereeGlobalStaticsEndpoint =>
    '${EnvironmentConfig.sprRefereeBaseURL}$_apiBasePath/global/statics';
