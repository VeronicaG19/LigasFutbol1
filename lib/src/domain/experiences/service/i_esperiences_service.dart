import '../../../core/typedefs.dart';
import '../entity/experiences.dart';

abstract class IExperiencesService {
  RepositoryResponse<List<Experiences>> getAllExperiencesByPlayer(int partyId);
}
