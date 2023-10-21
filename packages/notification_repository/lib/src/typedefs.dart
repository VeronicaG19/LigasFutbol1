import 'package:dartz/dartz.dart';

import 'exceptions/notification_failure.dart';

typedef RepoResponse<T> = Future<Either<NotificationFailure, T>>;
