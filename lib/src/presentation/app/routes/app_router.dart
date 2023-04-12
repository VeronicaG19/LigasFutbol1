// import 'package:go_router/go_router.dart';
//
// import 'route_utils.dart';
//
// class AppRouter {
//   late final AppService appService;
//   GoRouter get router => _goRouter;
//
//   AppRouter(this.appService);
//
//   late final GoRouter _goRouter = GoRouter(
//     refreshListenable: appService,
//     initialLocation: AppPage.home.toPath,
//     routes: <GoRoute>[
//       GoRoute(
//         path: AppPage.home.toPath,
//         name: AppPage.home.toName,
//         builder: (context, state) => const HomePage(),
//       ),
//       GoRoute(
//         path: AppPage.splash.toPath,
//         name: AppPage.splash.toName,
//         builder: (context, state) => const SplashPage(),
//       ),
//       GoRoute(
//         path: AppPage.login.toPath,
//         name: AppPage.login.toName,
//         builder: (context, state) => const LogInPage(),
//       ),
//       GoRoute(
//         path: AppPage.onBoarding.toPath,
//         name: AppPage.onBoarding.toName,
//         builder: (context, state) => const OnBoardingPage(),
//       ),
//       GoRoute(
//         path: AppPage.error.toPath,
//         name: AppPage.error.toName,
//         builder: (context, state) => ErrorPage(error: state.extra.toString()),
//       ),
//     ],
//     errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
//     redirect: (context, state) {
//       final loginLocation = state.namedLocation(APP_PAGE.login.toName);
//       final homeLocation = state.namedLocation(APP_PAGE.home.toName);
//       final splashLocation = state.namedLocation(APP_PAGE.splash.toName);
//       final onboardLocation = state.namedLocation(APP_PAGE.onBoarding.toName);
//
//       final isLogedIn = appService.loginState;
//       final isInitialized = appService.initialized;
//       final isOnboarded = appService.onboarding;
//
//       final isGoingToLogin = state.subloc == loginLocation;
//       final isGoingToInit = state.subloc == splashLocation;
//       final isGoingToOnboard = state.subloc == onboardLocation;
//
//       // If not Initialized and not going to Initialized redirect to Splash
//       if (!isInitialized && !isGoingToInit) {
//         return splashLocation;
//         // If not onboard and not going to onboard redirect to OnBoarding
//       } else if (isInitialized && !isOnboarded && !isGoingToOnboard) {
//         return onboardLocation;
//         // If not logedin and not going to login redirect to Login
//       } else if (isInitialized &&
//           isOnboarded &&
//           !isLogedIn &&
//           !isGoingToLogin) {
//         return loginLocation;
//         // If all the scenarios are cleared but still going to any of that screen redirect to Home
//       } else if ((isLogedIn && isGoingToLogin) ||
//           (isInitialized && isGoingToInit) ||
//           (isOnboarded && isGoingToOnboard)) {
//         return homeLocation;
//       } else {
//         // Else Don't do anything
//         return null;
//       }
//     },
//   );
// }
