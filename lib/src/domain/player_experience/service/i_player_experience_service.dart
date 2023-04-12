import '../../../core/typedefs.dart';
import '../entity/player_experience.dart';

abstract class IPlayerExperienceService {
  Future<List<PlayerExperience>> getPlayerExperience(int personId);
  RepositoryResponse<PlayerExperience> createExperience(
      PlayerExperience experience);
}
