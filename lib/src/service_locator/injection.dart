import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final locator = GetIt.instance;

/*@InjectableInit()
Future<void> configureDependencies() async => await $initGetIt(locator);*/
//upgrade to injectable 2.0
@InjectableInit(preferRelativeImports: false)
Future<void> configureDependencies() => locator.init();
