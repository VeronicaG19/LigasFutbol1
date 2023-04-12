import 'package:ligas_futbol_flutter/src/core/typedefs.dart';

import '../entity/experiences.dart';

abstract class IExperiencesRepository {
  RepositoryResponse<List<Experiences>> getAllExperiencesByPlayer(int partyId);
}
