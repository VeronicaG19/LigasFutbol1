import 'package:dartz/dartz.dart';
import 'package:datasource_client/datasource_client.dart';
import 'package:here_repository/here_repository.dart';

import '../constants.dart';
import '../endpoints.dart';
import '../typedef.dart';
import 'here_interface.dart';
import '../exceptions/here_exception.dart';
import 'here_service.dart';

class ApiHereReposiTory implements IApiHereInterface {
  final ApiClient _client;
  late final HereService _hereService = HereService();
  ApiHereReposiTory(this._client,
      {required String baseUrl, required String appName})
      : super() {
    Endpoints.init(baseUrl, appName);
  }

  @override
  HereRepoResponse<ApiHereResponseAddresses> getAddresssesWithText(
      String address) async {
    String addre = address.replaceAll(' ', '+');

    final request = await Task(() => _hereService.getAddres(kApiHereKey, addre))
        ._validateResponse();
    //_controller.add(request.getOrElse(() => ''));
    return request;
    /*return Task(() => _client.network.getData(
      endpoint: Endpoints.getApiHereSearchData,
      queryParams: {
        'apiKey' :kApiHereKey,
        'searchtext': addre
      },
      converter: ApiHereResponseAddresses.fromJson))._validateResponse();*/
  }

  @override
  HereRepoResponse<ReverseHeoApiHere> getReverseGeoAddres(
      String latLengt) async {
    final request =
        await Task(() => _hereService.getReverseGeo(kApiHereKey, latLengt))
            ._validateResponse();
    //_controller.add(request.getOrElse(() => ''));
    return request;
  }
}

extension _HereResponse<T> on Task<T> {
  HereRepoResponse<T> _validateResponse() {
    return attempt()
        .map(
          (either) => either.leftMap(
            (l) {
              if (l is HereException) {
                return HereFailure(code: l.name, message: l.message);
              } else if (l is NetworkException) {
                return HereFailure(code: l.name, message: l.message);
              } else {
                return HereFailure(code: 'UnknownError', message: l.toString());
              }
            },
          ),
        )
        .run();
  }
}
