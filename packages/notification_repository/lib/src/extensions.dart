import 'package:dartz/dartz.dart';
import 'package:datasource_client/datasource_client.dart';
import 'package:notification_repository/src/typedefs.dart';

import 'exceptions/notification_failure.dart';

extension ApiCall on ApiClient {
  RepoResponse<T> fetchData<T>({
    required String endpoint,
    JSON? queryParams,
    required T Function(JSON responseBody) converter,
  }) =>
      Task(() => network.getData(
          endpoint: endpoint,
          queryParams: queryParams,
          converter: converter)).attempt().mapLeftToFailure().run();

  RepoResponse<List<T>> fetchCollectionData<T>({
    required String endpoint,
    JSON? queryParams,
    required T Function(JSON responseBody) converter,
  }) =>
      Task(() => network.getCollectionData(
          endpoint: endpoint,
          queryParams: queryParams,
          converter: converter)).attempt().mapLeftToFailure().run();

  RepoResponse<T> postData<T>({
    required String endpoint,
    required JSON? data,
    required T Function(JSON responseBody) converter,
  }) =>
      Task(() => network.postData(
          endpoint: endpoint,
          data: data,
          converter: converter)).attempt().mapLeftToFailure().run();

  RepoResponse<T> updateData<T>({
    required String endpoint,
    required JSON? data,
    required T Function(JSON responseBody) converter,
  }) =>
      Task(() => network.updateData(
          endpoint: endpoint,
          data: data,
          converter: converter)).attempt().mapLeftToFailure().run();

  RepoResponse<T> deleteData<T>({
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
  Task<Either<NotificationFailure, U>> mapLeftToFailure() => map(
        (either) => either.leftMap(
          (l) {
            if (l is NetworkException) {
              return NotificationFailure(code: l.name, message: l.message);
            } else {
              return NotificationFailure(
                  code: 'UnknownError', message: l.toString());
            }
          },
        ),
      );
}
