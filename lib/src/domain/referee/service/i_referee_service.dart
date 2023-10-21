import 'package:user_repository/user_repository.dart';

import '../../../core/models/address_filter.dart';
import '../../../core/typedefs.dart';
import '../dto/create_referee_dto.dart';
import '../dto/referee_by_address.dart';
import '../entity/count_tournament_event.dart';
import '../entity/rating_referee_dto.dart';
import '../entity/referee.dart';
import '../entity/referee_by_league_dto.dart';
import '../entity/referee_detail_dto.dart';
import '../entity/referee_matches_dto.dart';
import '../entity/referee_statics.dart';

abstract class IRefereeService {
  RepositoryResponse<Referee> createReferee(
      CreateRefereeDTO referee, User user);

  ///Obtiene una lista de [RefereeByLeagueDTO]. Devuelve una lista vacia si ocurre un
  ///error o no encuentra datos.
  RepositoryResponse<List<RefereeByLeagueDTO>> getRefereeByLeague(int leagueId);
  Future<List<RefereeByLeagueDTO>> getRefereeByLeague2(int leagueId);

  ///Obtiene un objeto de tipo [RefereeDetailDTO]. Devuelve un objeto vacio si ocurre un
  ///error o no encuentra datos.
  RepositoryResponse<RefereeDetailDTO> getRefereeDetail(int refereeId);

  ///Obtiene una lista de [RefereeMatchesDTO]. Devuelve una lista vacia si ocurre un
  ///error o no encuentra datos.
  RepositoryResponse<List<RefereeMatchesDTO>> getRefereeMatches(int refereeId);

  ///Obtiene un objeto de tipo [RatingRefereeDTO]. Devuelve un objeto vacio si ocurre un
  ///error o no encuentra datos.
  RepositoryResponse<RatingRefereeDTO> getRefereeRating(int refereeId);

  RepositoryResponse<List<RefereeByLeagueDTO>> getRefereeByLeague1(
      int leagueId);
  RepositoryResponse<List<RefereeByLeagueDTO>> getSearchReferee1(int leagueId);

  Future<Referee> getRefereeDataByPersonId(int personId, String personName);

  Future<List<RefereeStatics>> getRefereeStatics(int personId, int leagueId);

  Future<List<CountEventTournament>> getTournamentEventCount(
      int refereeId, int leagueId,
      {int? tournamentId});

  RepositoryResponse<String> updateReferee(Referee referee);

  Future<List<RefereeByAddress>> searchByFiltersReferee(AddressFilter filter);
}
