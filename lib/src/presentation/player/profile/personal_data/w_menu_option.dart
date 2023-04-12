import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums.dart';
import '../../../../service_locator/injection.dart';
import 'cubit/personal_data_cubit.dart';
import 'w_form_content.dart';

class PDMenuOption extends StatelessWidget {
  const PDMenuOption(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.action})
      : super(key: key);

  final IconData icon;
  final String title;
  final String subtitle;
  final PersonalDataSubmitAction action;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        if (kIsWeb) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Actualizar datos'),
                content: BlocProvider(
                  create: (_) => locator<PersonalDataCubit>()
                    ..getCacheVerificationCode(action),
                  child: const _DialogContent(
                    height: 300,
                  ),
                ),
              );
            },
          );
        } else {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            //useSafeArea: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return BlocProvider(
                create: (_) => locator<PersonalDataCubit>()
                  ..getCacheVerificationCode(action),
                child: _DialogContent(
                  height: MediaQuery.of(context).size.height * 0.75,
                ),
              );
            },
          );
        }
      },
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({Key? key, required this.height}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final action = context
        .select((PersonalDataCubit cubit) => cubit.state.isVerificationScreen);
    return Container(
      height: action && kIsWeb ? 450 : height,
      width: !kIsWeb ? MediaQuery.of(context).size.width : 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
            child: FormDataContent(),
          ),
        ),
      ),
    );
  }
}
