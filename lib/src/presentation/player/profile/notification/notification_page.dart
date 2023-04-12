import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../app/bloc/authentication_bloc.dart';
import 'cubit/notification_cubit.dart';

class NotificationV extends StatelessWidget {
  const NotificationV({super.key});

  // static Route route() =>
  //     MaterialPageRoute(builder: (_) => const NotificationV());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoaded) {
          return Container(
            height: 400,
            color: const Color.fromARGB(255, 236, 236, 236),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Rol actual ${user.getCurrentRol}'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Recibir notificaciones'),
                  ),
                  ToggleSwitch(
                    initialLabelIndex:
                        state.configuration.notificationFlag == 'N' ? 1 : 0,
                    totalSwitches: 2,
                    labels: const [
                      'Si',
                      'No',
                    ],
                    onToggle: context
                        .read<NotificationCubit>()
                        .onUpdateNotificationFlag,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blueAccent, size: 50),
          );
        }
      },
    );
    // return Scaffold(
    //   //drawer: Drawer(),
    //   appBar: PreferredSize(
    //     preferredSize: const Size.fromHeight(70),
    //     child: AppBar(
    //       backgroundColor: Colors.grey[200],
    //       title: Text(
    //         'Notificaciones',
    //         style:
    //             TextStyle(color: Colors.grey[200], fontWeight: FontWeight.w900),
    //       ),
    //       flexibleSpace: const Image(
    //         image: AssetImage('assets/images/imageAppBar25.png'),
    //         fit: BoxFit.cover,
    //       ),
    //       elevation: 0.0,
    //     ),
    //   ),
    //   backgroundColor: Colors.grey[200],
    //   body: Center(
    //     child: Container(
    //       color: Colors.grey,
    //       child: Column(
    //         children: [
    //           const SizedBox(
    //             height: 30,
    //           ),
    //           Expanded(
    //             child: Container(
    //               decoration: const BoxDecoration(
    //                 color: Color.fromARGB(255, 240, 235, 235),
    //                 borderRadius: BorderRadius.only(
    //                   topRight: Radius.circular(20.0),
    //                   topLeft: Radius.circular(20.0),
    //                 ),
    //               ),
    //               child: ListView(
    //                 physics: const BouncingScrollPhysics(),
    //                 children: [
    //                   ListTile(
    //                     leading: const Icon(Icons.settings),
    //                     title: const Text('Notificaciones'),
    //                     subtitle:
    //                         const Text("Usted está recibiendo notificaciones"),
    //                     onTap: () {},
    //                   ),
    //                   ToggleSwitch(
    //                     initialLabelIndex: 0,
    //                     totalSwitches: 2,
    //                     labels: const ['Activar', 'Desactivar'],
    //                     onToggle: (index) {
    //                       print('switched to: $index');
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
