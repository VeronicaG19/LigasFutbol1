import 'package:dartz/dartz.dart';

import 'exceptions/user_failure.dart';

typedef RepoResponse<T> = Future<Either<UserFailure, T>>;
