import 'package:dartz/dartz.dart';
import 'package:datasource_client/datasource_client.dart';

import 'exception/lf_app_failure.dart';
import 'typedefs.dart';

extension ResponseValidator<T> on Future<T> {
  RepositoryResponse<T> validateResponse() {
    return Task(() => this)
        .attempt()
        .map(
          (either) => either.leftMap(
            (l) {
              if (l is NetworkException) {
                return LFAppFailure(
                    code: l.name, errorMessage: l.message, data: l.data);
              } else {
                return LFAppFailure(
                    code: 'UnknownError', errorMessage: l.toString());
              }
            },
          ),
        )
        .run();
  }
}
