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

abstract class IRefereeRepository {
  RepositoryResponse<Referee> createReferee(CreateRefereeDTO referee);
  RepositoryResponse<List<RefereeByLeagueDTO>> getRefereeByLeague(int leagueId);
  RepositoryResponse<List<RefereeByLeagueDTO>> getSearchReferee(int leagueId);
  RepositoryResponse<RefereeDetailDTO> getRefereeDetail(int refereeId);
  RepositoryResponse<List<RefereeMatchesDTO>> getRefereeMatches(int refereeId);
  RepositoryResponse<RatingRefereeDTO> getRefereeRating(int refereeId);
  RepositoryResponse<Referee> getRefereeDataByPersonId(int personId);
  RepositoryResponse<List<RefereeStatics>> getRefereeStatics(
      int personId, int leagueId);
  RepositoryResponse<List<CountEventTournament>> getTournamentEventCount(
      int refereeId, int leagueId,
      {int? tournamentId});
  RepositoryResponse<String> updateReferee(Referee referee);
  RepositoryResponse<List<RefereeByAddress>> searchByFiltersReferee(
      AddressFilter filter);
}
