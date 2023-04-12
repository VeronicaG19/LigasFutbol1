import 'package:dartz/dartz.dart';

import 'exceptions/auth_failure.dart';

typedef RepoResponse<T> = Future<Either<AuthFailure, T>>;
