import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/login/cubit/login_cubit.dart';
import '../../../presentation/login/view/login_form.dart';
import '../../../service_locator/injection.dart';
import 'login_form_web.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (kIsWeb) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/imageLoggin21.png'),
                  fit: BoxFit.fill),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  right: screenSize.width / 4,
                  left: screenSize.width / 4,
                ),
                child: Container(
                  padding: EdgeInsets.only(top: screenSize.height * 0.1),
                  //height: 600.0,
                  color: const Color(0xFF6C6565).withOpacity(0.5),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenSize.width / 18,
                      right: screenSize.width / 18,
                    ),
                    child: BlocProvider(
                      create: (_) => locator<LoginCubit>(),
                      child: const LoginFormWeb(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/imageLoggin21.png'),
                fit: BoxFit.fill),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 40, bottom: 40),
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                //height: 600.0,
                color: const Color(0xFF6C6565).withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: BlocProvider(
                    create: (_) => locator<LoginCubit>(),
                    child: const LoginForm(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
