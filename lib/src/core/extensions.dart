import 'package:dartz/dartz.dart';
import 'package:datasource_client/datasource_client.dart';
import 'package:intl/intl.dart';

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

extension ApiCall on ApiClient {
  RepositoryResponse<T> fetchData<T>({
    required String endpoint,
    JSON? queryParams,
    required T Function(JSON responseBody) converter,
  }) =>
      Task(() => network.getData(
          endpoint: endpoint,
          queryParams: queryParams,
          converter: converter)).attempt().mapLeftToFailure().run();

  RepositoryResponse<List<T>> fetchCollectionData<T>({
    required String endpoint,
    JSON? queryParams,
    bool? requiresAuthToken,
    required T Function(JSON responseBody) converter,
  }) =>
      Task(() => network.getCollectionData(
          requiresAuthToken: requiresAuthToken ?? true,
          endpoint: endpoint,
          queryParams: queryParams,
          converter: converter)).attempt().mapLeftToFailure().run();

  RepositoryResponse<T> postData<T>({
    required String endpoint,
    required JSON? data,
    required T Function(JSON responseBody) converter,
  }) =>
      Task(() => network.postData(
          endpoint: endpoint,
          data: data,
          converter: converter)).attempt().mapLeftToFailure().run();

  RepositoryResponse<T> updateData<T>({
    required String endpoint,
    required JSON? data,
    required T Function(JSON responseBody) converter,
  }) =>
      Task(() => network.updateData(
          endpoint: endpoint,
          data: data,
          converter: converter)).attempt().mapLeftToFailure().run();

  RepositoryResponse<T> deleteData<T>({
    required String endpoint,
    JSON? data,
    required T Function(JSON responseBody) converter,
  }) =>
      Task(() => network.deleteData(
          endpoint: endpoint,
          data: data,
          converter: converter)).attempt().mapLeftToFailure().run();
}

extension _TaskX<U> on Task<Either<Object, U>> {
  Task<Either<LFAppFailure, U>> mapLeftToFailure() => map(
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
      );
}

extension DateFormatting on DateTime {
  String dateForTransactionFormat() => DateFormat("yyyy-MM-dd").format(this);
  String dateToUIFormat() => DateFormat.yMMMMd().format(this);
}
