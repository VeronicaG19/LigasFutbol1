import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/constans.dart';
import '../../../widgets/CoachmarkDesc.dart';

enum TutorialType {
  referee,
  ligueAdminMain,
  ligueAdminCat,
  ligueAdminTournmnt,
  ligurTournmanetConfig,
  ligeRoleGameTutorial,
  player,
  adminTeam,
  filedOwner,
  filedOwner2,
  qualifyPlayer,
  qualifyReferre,
  qualifyRepresentative,
  qualifyLeagueManager
}

class TutorialWidget extends StatefulWidget {
  const TutorialWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tuto,
  }) : super(key: key);

  final TutorialType tuto;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  State<TutorialWidget> createState() => _TutorialWidgetState();
}

class _TutorialWidgetState extends State<TutorialWidget> {
  bool enabled = true;
  TutorialCoachMark? tutorialCoachMark;

  List<TargetFocus> targets = [];

  void executeTutorial() {
    Future.delayed(const Duration(seconds: 1), () {
      _showTutorialCoachmark();
    });
  }

  void _showTutorialCoachmark() {
    if (widget.tuto == TutorialType.referee) {
      _initTargetRefreee();
    } else if (widget.tuto == TutorialType.player) {
      playerTuto();
    } else if (widget.tuto == TutorialType.adminTeam) {
      teamManagerTuto();
    } else if (widget.tuto == TutorialType.filedOwner) {
      filedAdminTuto1();
    }
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      pulseEnable: false,
      onClickTarget: (target) {
        if (target.identify == "reportHistory-key") {
          Navigator.pop(context);
        } else if (target.identify == "playerData-key") {
          Navigator.pop(context);
        } else if (target.identify == "miteamsTemM-key") {
          Navigator.pop(context);
        } else if (target.identify == "myprofile11-key") {
          Navigator.pop(context);
        }
        print("${target.identify}");
      },
      hideSkip: true,
      alignSkip: Alignment.topRight,
      onFinish: () {},
    )..show(context: context);
  }

  void _initTargetRefreee() {
    targets = [
      // my profile
      TargetFocus(
        identify: "myprofile-key",
        keyTarget: CoachKey.myProfile,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podemos editar los datos de nuestra cuenta",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          )
        ],
      ),
      //ficha de arbitro
      TargetFocus(
        identify: "refereeProfile-key",
        keyTarget: CoachKey.refereeProfile,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podemos editar la direccion, agenda y tarifas.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          )
        ],
      ),

      //ver calendario
      TargetFocus(
        identify: "showCalendar-key",
        keyTarget: CoachKey.showCalendar,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podemos ver los calendarios por arbitrar",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          )
        ],
      ),

      //ver historisl de reportes
      TargetFocus(
        identify: "reportHistory-key",
        keyTarget: CoachKey.reportHistory,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podemos ver los reportes arbitreales",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  Navigator.pop(context);
                  controller.next();
                },
              );
            },
          )
        ],
      ),

      //cambio de ligas
      TargetFocus(
        identify: "changeLigesKey-key",
        keyTarget: CoachKey.changeLigesKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podemos cambiar las ligas en las cuales estamos registrados",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          )
        ],
      ),

      //notificaciones
      TargetFocus(
        identify: "notificationKey-key",
        keyTarget: CoachKey.notificationKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos visualizar las solicitudes enviadas, recibidas y de partidos por arbitrar",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),

      //mis partidos
      TargetFocus(
        identify: "matchesKey-key",
        keyTarget: CoachKey.matchesKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos ver los partidos asignados.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),
      //mis partidos
      TargetFocus(
        identify: "myMatchesReferee-key",
        keyTarget: CoachKey.myMatchesReferee,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos ver los partidos asignados ya sea finalizados, iniciados o pendientes.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),

      //mis partidos
      TargetFocus(
        identify: "allMyMatchesReferee-key",
        keyTarget: CoachKey.allMyMatchesReferee,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos ver todos los partidos sin filtros.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),

      //mis ligas
      TargetFocus(
        identify: "liguesReferee-key",
        keyTarget: CoachKey.liguesReferee,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podemos ver las ligas a las cuales nos podemos unir.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),

      //estadisticas arbitrales
      TargetFocus(
        identify: "statiscReferee-key",
        keyTarget: CoachKey.statiscReferee,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podemos ver las estadisticas arbitrales.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),
    ];
  }

  void mainMenuLeagueAdmin() {
    targets = [
      // my profile
      TargetFocus(
        identify: "mainMenuLeagueAdmin-key",
        keyTarget: CoachKey.mainMenuLeagueAdmin,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podemos crear torneos y enviar solicitudes para nueva liga",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  void playerTuto() {
    targets = [
      //mi perfil
      TargetFocus(
        identify: "myprofile-key",
        keyTarget: CoachKey.myProfile,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos cambiar nuestros datos personales y solicitar un nuevo rol en la aplicación.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),

      //ficha de jugador
      TargetFocus(
        identify: "playerData-key",
        keyTarget: CoachKey.playerData,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos editar nuestra posición, nuestro sobre nombre, fecha de nacimiento, la direccion, igual vamos a poder ver nestros partidos y agregar nuestra experiencia.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  Navigator.pop(context);
                  controller.next();
                },
              );
            },
          ),
        ],
      ),

      //mis equipos
      TargetFocus(
        identify: "myTeamsPlayer-key",
        keyTarget: CoachKey.myTeamsPlayer,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos ver los equipos a los cuales estamos inscritos.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),

      //mis partidos
      TargetFocus(
        identify: "myMatchPlayer-key",
        keyTarget: CoachKey.myMatchPlayer,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos ver los partidos filtrados por equipo inscrito.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),

      //mis partidos
      TargetFocus(
        identify: "searchTeamsPlayer-key",
        keyTarget: CoachKey.searchTeamsPlayer,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos buscar equipos y enviarles solicitudes para pertener al equipo seleccionado.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),
    ];
  }

  void teamManagerTuto() {
    targets = [
      //mi perfil
      TargetFocus(
        identify: "myprofile-key",
        keyTarget: CoachKey.myProfile,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos cambiar nuestros datos personales y solicitar un nuevo rol en la aplicación.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),
      //mis equipos
      TargetFocus(
        identify: "miteamsTemM-key",
        keyTarget: CoachKey.miteamsTemM,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos cambiar entre equipos creados e igual podemos enviar solicitud para un nuevo equipo",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  Navigator.pop(context);
                  controller.next();
                },
              );
            },
          ),
        ],
      ),
      //mis equipos
      TargetFocus(
        identify: "adminTeamTemM-key",
        keyTarget: CoachKey.adminTeamTemM,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos administrar nuestro equipo, cambiar el logo, los uniformes de visitante y local de igual manera vamos a poder agregar a jugadores.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),
      //agregar jugador
      TargetFocus(
        identify: "newPlayerTemM-key",
        keyTarget: CoachKey.newPlayerTemM,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Con este boton vamos a poder agregar jugadores a nuestro equipo o buscar jugadores y enviarles solicitud.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),

      //mis partidos
      TargetFocus(
        identify: "myMatchesTemM-key",
        keyTarget: CoachKey.myMatchesTemM,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder ver los partidos que tenemos asignados.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),

      //mis torneos
      TargetFocus(
        identify: "tournamentTemM-key",
        keyTarget: CoachKey.tournamentTemM,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder ver los torneos en los que hemos participado.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),
    ];
  }

  void filedAdminTuto1() {
    targets = [
      //mi perfil
      TargetFocus(
        identify: "myprofile11-key",
        keyTarget: CoachKey.myProfile,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta seccion podemos cambiar nuestros datos personales y solicitar un nuevo rol en la aplicación.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  Navigator.pop(context);
                  controller.next();
                },
              );
            },
          ),
        ],
      ),

      //crear campo
      TargetFocus(
        identify: "addField-key",
        keyTarget: CoachKey.addField,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder crear un campo.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),

      //lista campo
      TargetFocus(
        identify: "listFields-key",
        keyTarget: CoachKey.listFields,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí se muestra la lista de campos y al seleccionar uno te lleva al detalle de campos.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: AbsorbPointer(
        absorbing: !enabled,
        child: ListTile(
          leading: CircleAvatar(
            radius: 15,
            backgroundColor: const Color(0xff358aac),
            child: Icon(
              widget.icon,
              color: Colors.grey[200],
              size: 19,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
          ),
          title: Text(widget.title, style: const TextStyle(fontSize: 14)),
          subtitle: Text(widget.subtitle, style: const TextStyle(fontSize: 12)),
          onTap: () {
            executeTutorial();
            setState(() {
              enabled = false;
            });
          },
        ),
      ),
    );
  }
}
