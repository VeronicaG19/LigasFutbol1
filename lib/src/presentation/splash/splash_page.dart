import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/environment_config.dart';
import 'package:ligas_futbol_flutter/src/presentation/home_page.dart';
import 'package:splash_view/splash_view.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SplashPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashView(
        backgroundImageDecoration: BackgroundImageDecoration(
            image: AssetImage(
              EnvironmentConfig.logoImage,
            ),
            fit: BoxFit.cover,
            opacity: 0.9),
        logo: Image.asset(
          EnvironmentConfig.logoImage,
          width: 200,
          height: 200,
          opacity: const AlwaysStoppedAnimation(.8),
        ),
        showStatusBar: true,
        loadingIndicator: const CircularProgressIndicator(color: Colors.amber),
        done: Done(
          const HomePage(),
          animationDuration: const Duration(seconds: 10),
          curve: Curves.fastLinearToSlowEaseIn,
        ),
      ),
    );
  }
}
