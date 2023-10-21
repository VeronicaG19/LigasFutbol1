import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';

import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';
import '../../../core/typedefs.dart';
import '../entity/experiences.dart';
import 'i_experiences_repository.dart';

@LazySingleton(as: IExperiencesRepository)
class ExperienceRepositoryImpl implements IExperiencesRepository {
  final ApiClient _apiClient;

  ExperienceRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<Experiences>> getAllExperiencesByPlayer(int partyId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: getAllExperiencesByPlayerEndpoint + "/$partyId",
            converter: Experiences.fromJson)
        .validateResponse();
  }
}
