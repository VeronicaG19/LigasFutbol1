import 'package:dartz/dartz.dart';

import 'exception/lf_app_failure.dart';

typedef RepositoryResponse<T> = Future<Either<LFAppFailure, T>>;
