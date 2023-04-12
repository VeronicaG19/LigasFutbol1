import 'package:flutter/widgets.dart';

import '../../home_page.dart';
import '../../root/root_page.dart';
import '../bloc/authentication_bloc.dart';
import '../view/loading_screen.dart';

List<Page> onGenerateAppViewPages(
    AuthenticationStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AuthenticationStatus.authenticated:
      return [RootPage.page()];
    case AuthenticationStatus.unauthenticated:
      return [HomePage.page()];
    // case AuthenticationStatus.initialAdvice:
    //   return [SplashPage.page()];
    default:
      return [LoadingScreen.page()];
  }
}
