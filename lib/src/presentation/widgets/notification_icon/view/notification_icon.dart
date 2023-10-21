import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../../../app/app.dart';
import '../../../field_owner/requests_page/view/fo_requests_page.dart';
import '../../../league_manager/request/view/request_page.dart';
import '../../../referee/referee_requests/view/ref_requests_page.dart';
import '../../../representative/requests/view/rep_requests_page.dart';
import '../../../user_requests/view/user_requests_page.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key? key, required this.applicationRol})
      : super(key: key);

  final ApplicationRol applicationRol;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (applicationRol == ApplicationRol.player) {
          Navigator.push(
            context,
            UserRequestsPage.route(),
          ).then((value) {
            return true;
          });
        } else if (applicationRol == ApplicationRol.leagueManager) {
          Navigator.push(
            context,
            LMRequests.route(),
            // UserRequestsPage.route(
            //     BlocProvider.of<NotificationCountCubit>(context)),
          );
        } else if (applicationRol == ApplicationRol.teamManager) {
          Navigator.push(
            context,
            RepRequestsPage.route(),
            // UserRequestsPage.route(
            //     BlocProvider.of<NotificationCountCubit>(context)),
          );
        } else if (applicationRol == ApplicationRol.referee) {
          Navigator.push(
            context,
            RefRequestsPage.route(),
            // UserRequestsPage.route(
            //     BlocProvider.of<NotificationCountCubit>(context)),
          );
        } else if (applicationRol == ApplicationRol.fieldOwner) {
          Navigator.push(
            context,
            FoRequestPage.route(),
          );
        }
      },
      child: Row(
        children: [
          Stack(
            children: [
              Icon(
                Icons.notifications_active_sharp,
                size: 25,
                color: Colors.grey[200],
              ),
              BlocBuilder<NotificationBloc, NotificationState>(
                buildWhen: (previous, current) =>
                    previous.notificationCount != current.notificationCount,
                builder: (context, state) {
                  if (state.notificationCount == 0) {
                    return const SizedBox();
                  }
                  return Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red[800]),
                      alignment: Alignment.center,
                      child: Text(
                        '${state.notificationCount}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 9),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          (kIsWeb) ? const SizedBox(width: 10) : const SizedBox(width: 0),
          (kIsWeb)
              ? Text(
                  'Notificaciones',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    color: Colors.grey[200],
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                )
              : const SizedBox(width: 0),
        ],
      ),
    );
  }
}
