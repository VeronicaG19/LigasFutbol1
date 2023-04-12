import '../../../core/typedefs.dart';
import '../entity/player_experience.dart';

abstract class IPlayerExperienceRepository {
  RepositoryResponse<List<PlayerExperience>> getPlayerExperience(int personId);
  RepositoryResponse<PlayerExperience> createExperience(
      PlayerExperience experience);
}
