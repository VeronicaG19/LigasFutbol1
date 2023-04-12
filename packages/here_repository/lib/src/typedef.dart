import 'package:dartz/dartz.dart';

import 'exceptions/here_failure.dart';

typedef HereRepoResponse<T> = Future<Either<HereFailure, T>>;
