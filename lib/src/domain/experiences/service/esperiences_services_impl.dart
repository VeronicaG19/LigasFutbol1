import 'package:injectable/injectable.dart';

import '../../../core/typedefs.dart';
import '../entity/experiences.dart';
import '../repository/i_experiences_repository.dart';
import 'i_esperiences_service.dart';

@LazySingleton(as: IExperiencesService)
class ExperienceServiceImpl implements IExperiencesService {
  final IExperiencesRepository _repository;

  ExperienceServiceImpl(this._repository);

  @override
  RepositoryResponse<List<Experiences>> getAllExperiencesByPlayer(int partyId) {
    return _repository.getAllExperiencesByPlayer(partyId);
  }
}
