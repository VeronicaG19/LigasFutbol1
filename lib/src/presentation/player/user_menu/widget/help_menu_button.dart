import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/user_menu/widget/tutorial_widget.dart';
import 'package:new_im_animations/im_animations.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/constans.dart';
import '../../../widgets/CoachmarkDesc.dart';

class HelpMeButton extends StatefulWidget {
  const HelpMeButton({
    Key? key,
    required this.iconData,
    required this.tuto,
  }) : super(key: key);

  final IconData iconData;
  final TutorialType tuto;

  @override
  State<HelpMeButton> createState() => _HelpMeButtonState();
}

class _HelpMeButtonState extends State<HelpMeButton> {
  TutorialCoachMark? tutorialCoachMark;

  List<TargetFocus> targets = [];

  void executeTutorial() {
    Future.delayed(const Duration(seconds: 1), () {
      _showTutorialCoachmark();
    });
  }

  void _showTutorialCoachmark() {
    if (widget.tuto == TutorialType.ligueAdminMain) {
      mainMenuLeagueAdmin();
    } else if (widget.tuto == TutorialType.ligueAdminCat) {
      categoryMainAdminLeage();
    } else if (widget.tuto == TutorialType.ligueAdminTournmnt) {
      ligueAdminTournamnet();
    } else if (widget.tuto == TutorialType.ligurTournmanetConfig) {
      tournamentConfiguration();
    } else if (widget.tuto == TutorialType.ligeRoleGameTutorial) {
      roleGemTutorial();
    } else if (widget.tuto == TutorialType.filedOwner2) {
      fieldManagerTuto2();
    } else if (widget.tuto == TutorialType.qualifyPlayer) {
      qualifyPlayer();
    } else if (widget.tuto == TutorialType.qualifyReferre) {
      qualifyReferee();
    } else if (widget.tuto == TutorialType.qualifyRepresentative) {
      qualifyRepresentative();
    } else if (widget.tuto == TutorialType.qualifyLeagueManager) {
      qualifyLeagueManager();
    }
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      pulseEnable: false,
      onClickTarget: (target) {
        if (target.identify == "reportHistory-key") {
          Navigator.pop(context);
        } else if (target.identify == 'refereeRoleGame-key') {
          Scrollable.ensureVisible(CoachKey.sendRequesRoleGame.currentContext!);
          FocusScope.of(context).requestFocus(FocusNode());
        } else if (target.identify == "cleanRoleGame-key") {
          Scrollable.ensureVisible(CoachKey.fieldRoleGame.currentContext!);
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      // hideSkip: false,
      // skipWidget: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(5),
      //     color: Colors.red,
      //   ),
      //   child: const Padding(
      //     padding: EdgeInsets.all(10),
      //     child: Text(
      //       'Finalizar',
      //       style: TextStyle(
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),
      alignSkip: Alignment.topLeft,
      onFinish: () {
        print("Finish");
      },
    )..show(context: context);
  }

  void mainMenuLeagueAdmin() {
    targets = [
      // category page tournamnet
      TargetFocus(
        identify: "catMainPageLeageAdm-key",
        keyTarget: CoachKey.catMainPageLeageAdm,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Primero que nada debes crear tu categoría para poder recibir solicitudes de los Representantes de Equipo y de Árbitros.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      // notification icon tournamnet
      TargetFocus(
        identify: "notificationKey-key",
        keyTarget: CoachKey.notificationAdKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podrás aprobar las solicitudes de los Representantes de Equipo y de Árbitros para que puedas iniciar tu Torneo.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      // teams main page tournamnet
      TargetFocus(
        identify: "teamMainPageLeageAdm-key",
        keyTarget: CoachKey.teamMainPageLeageAdm,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podrás visualizar los Equipos que ya pertenecen a tu Liga.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //  tournament mainpage admin leage
      TargetFocus(
        identify: "tournamentMainPageLeageAdm-key",
        keyTarget: CoachKey.tournamentMainPageLeageAdm,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podrás crear tu Torneo, Agregar Equipos, Crear Rol de Juegos, así como Asignar Árbitros y Campos a los partidos.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      // mian page tournamnet
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
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //main page referee
      TargetFocus(
        identify: "refereeMainLeagueAdmin-key",
        keyTarget: CoachKey.refereeMainLeagueAdmin,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podemos buscar arbitros para ver sus tarifas y disponibilidad.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //main page field
      TargetFocus(
        identify: "fieldMainLeagueAdmin-key",
        keyTarget: CoachKey.fieldMainLeagueAdmin,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podemos ver la disponibilidad, tarifa y ubicación del campo.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  void categoryMainAdminLeage() {
    targets = [
      //main page category
      TargetFocus(
        identify: "mainSelectCategoryAdminLeg-key",
        keyTarget: CoachKey.mainSelectCategoryAdminLeg,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podemos seleccionar las categorias disponibles.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //on selected cat
      TargetFocus(
        identify: "onselectedCatAdminLeag-key",
        keyTarget: CoachKey.onselectedCatAdminLeag,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Una vez seleccionada la categoria aquí podemos editar y/o borrar la categoria seleccionada.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //torneo actual
      /*TargetFocus(
        identify: "categoryThisTournament-key",
        keyTarget: CoachKey.categoryThisTournament,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Cuando se seleccione la categoria aquí podremos observar la tabla de posiciones y tabla de goleo del torneo actual.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          )
        ],
      ),*/

      //torneos pasados
      TargetFocus(
        identify: "pastTournaments-key",
        keyTarget: CoachKey.pastTournaments,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Cuando se seleccione la categoria aquí podremos observar los torneos pasado de la categoria.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),

      //agregar categoria
      TargetFocus(
        identify: "addCategoryCategory-key",
        keyTarget: CoachKey.addCategoryCategory,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Y por ultimo aquí vamos a poder crear categorias.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  void ligueAdminTournamnet() {
    targets = [
      //lista de categorias
      TargetFocus(
        identify: "catListTournament-key",
        keyTarget: CoachKey.catListTournament,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí se mostrara una lista desplegable con las categorias y al seleccionarla se mostraran los torneos.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //lista de torneos
      TargetFocus(
        identify: "selectTournamentLi-key",
        keyTarget: CoachKey.selectTournamentLi,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí se mostraran los torneos disponibles por la categoria o los filtros seleccionados.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),

      //buscar torneo
      TargetFocus(
        identify: "filterTournament1-key",
        keyTarget: CoachKey.filterTournament1,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "En esta sección se pueden buscar los torneos por nombre.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),

      //crear torneo
      TargetFocus(
        identify: "addTournamentButtn-key",
        keyTarget: CoachKey.addTournamentButtn,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podemos crear un torneo.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  void tournamentConfiguration() {
    targets = [
      //configuracion de torneo
      TargetFocus(
        identify: "configTournament-key",
        keyTarget: CoachKey.configTournament,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder editar toda la configuracion del torneo.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),

      //equipos de torneo
      TargetFocus(
        identify: "teamsTournament-key",
        keyTarget: CoachKey.teamsTournament,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder agregar equipos al torneo y podemos ver que equipos estan inscritos al torneo.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),

      //rol de juegos
      TargetFocus(
        identify: "roleGamesTournament-key",
        keyTarget: CoachKey.roleGamesTournament,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder crear nuestros roles de juegos de manera automatica, igual vamos a poder agendarlos y enviar solicitud al dueño de campo y arbitro.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //clasificacion
      TargetFocus(
        identify: "clasificationTournament-key",
        keyTarget: CoachKey.clasificationTournament,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder ver la tabla de clasificacion del torneo y de igual manera vamos a poder editar el sistema de puntuaciones.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),

      //tabla de goleo
      TargetFocus(
        identify: "scoreTable-key",
        keyTarget: CoachKey.scoreTable,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder ver la tabla de goleo del torneo, vamos a observar la posicion, el nombre del jugador y los goles anotados.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),

      //tabla de goleo
      TargetFocus(
        identify: "miniLigue-key",
        keyTarget: CoachKey.miniLigue,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder ver nuestra liguilla y crear partidos para dicha liguilla.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  void roleGemTutorial() {
    targets = [
      //fecha
      TargetFocus(
        identify: "dateRoleGame-key",
        keyTarget: CoachKey.dateRoleGame,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder cambiar la fecha de nuestros partidos, igual sirve para buscar arbitros y campos disponibles.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //hora
      TargetFocus(
        identify: "hourRoleGame-key",
        keyTarget: CoachKey.hourRoleGame,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder cambiar la hora de nuestros partidos, igual sirve para buscar arbitros y campos disponibles.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //lugar
      TargetFocus(
        identify: "placeRolGame-key",
        keyTarget: CoachKey.placeRolGame,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí podremos filtar los campos y partidos disponibles en ese lugar, igual dependiendo de la hora y fecha establecida.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //buscar
      TargetFocus(
        identify: "searchButtonRoleGame-key",
        keyTarget: CoachKey.searchButtonRoleGame,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Este boton sirve para buscar arbitros y campos con base en los filtros seleccionados y establecidos.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //limpiar
      TargetFocus(
        identify: "cleanRoleGame-key",
        keyTarget: CoachKey.cleanRoleGame,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Este boton sirve para limpiar los campos de hora, fecha y la seleccion de lugar",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  Scrollable.ensureVisible(
                      CoachKey.fieldRoleGame.currentContext!);
                  FocusScope.of(context).requestFocus(FocusNode());
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //detalle campo
      TargetFocus(
        identify: "fieldRoleGame-key",
        keyTarget: CoachKey.fieldRoleGame,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí se mostrara el detalle del campo seleccionado como la disponibilidad, tarifa, ubicacion y en caso de enviar una solicitud esta se puede cancelar.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  Scrollable.ensureVisible(
                      CoachKey.refereeRoleGame.currentContext!);
                  FocusScope.of(context).requestFocus(FocusNode());
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //detalle arbitro
      TargetFocus(
        identify: "refereeRoleGame-key",
        keyTarget: CoachKey.refereeRoleGame,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí se mostrara el detalle del arbitro seleccionado como la disponibilidad, tarifa y en caso de enviar una solicitud esta se puede cancelar.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  //   Scrollable.ensureVisible(CoachKey.sendRequesRoleGame.currentContext!);
                  // FocusScope.of(context).requestFocus(FocusNode());
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      //detalle arbitro
      /* TargetFocus(
        identify: "sendRequesRoleGame-key",
        keyTarget: CoachKey.sendRequesRoleGame,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Este boton nos ayudara a enviar la solicitud al arbitro y campo seleccionado",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
              );
            },
          )
        ],
      ),*/
    ];
  }

  void fieldManagerTuto2() {
    targets = [
      //disponibilidad
      TargetFocus(
        identify: "agendField-key",
        keyTarget: CoachKey.agendField,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder agregar la disponibilidad del campo seleccionado.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),

      //tarifas
      TargetFocus(
        identify: "priecesField-key",
        keyTarget: CoachKey.priecesField,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder agregar las tarifas del campo seleccionado.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),

      //tarifas
      TargetFocus(
        identify: "detailField-key",
        keyTarget: CoachKey.detailField,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder editar la información del campo seleccionado.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  void qualifyPlayer() {
    targets = [
      TargetFocus(
        identify: "localTeamInformation-key",
        keyTarget: CoachKey.localTeamInformation,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder ver el equipo local del partido seleccionado.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "visitTeamInformation-key",
        keyTarget: CoachKey.visitTeamInformation,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder ver el equipo visitante del partido seleccionado.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "statusMatch-key",
        keyTarget: CoachKey.statusMatch,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder ver el status del partido dependiendo "
                  "si el partido esta PENDIENTE, EMPATADO o FINALIZADO.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "qualifyReferee-key",
        keyTarget: CoachKey.qualifyReferee,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder calificar al árbitro del partido seleccionado.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "qualifyFieldOwner-key",
        keyTarget: CoachKey.qualifyFieldOwner,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder calificar al campo,sus instalaciones o algún "
                  "problema que se aya presentado durante el partido.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  void qualifyReferee() {
    targets = [
      TargetFocus(
        identify: "localTeamQualify-key",
        keyTarget: CoachKey.localTeamQualify,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder calificar al equipo local.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "visitTeamQualify-key",
        keyTarget: CoachKey.visitTeamQualify,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder calificar al equipo visitante .",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "statusMatch-key",
        keyTarget: CoachKey.statusMatch,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder ver el status del partido dependiendo "
                  "si el partido esta PENDIENTE, EMPATADO o FINALIZADO.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "fieldOwnerTeamQualify-key",
        keyTarget: CoachKey.fieldOwnerTeamQualify,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder calificar al campo seleccionado.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "reviewPlayers-key",
        keyTarget: CoachKey.reviewPlayers,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder ver las reseñas hechas por los jugadores.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  void qualifyRepresentative() {
    targets = [
      TargetFocus(
        identify: "qualifyPlayers-key",
        keyTarget: CoachKey.qualifyPlayers,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder ver las reseñas hechas por los jugadores.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  void qualifyLeagueManager() {
    targets = [
      TargetFocus(
        identify: "qualifyPlayers-key",
        keyTarget: CoachKey.qualifyGeneralRating,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                container: Text(
                  "Aquí vamos a poder ver las reseñas hechas por los jugadores.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Color? color = Colors.blue[800];
    return GestureDetector(
      child: HeartBeat(
        child: CircleAvatar(
          child: Icon(
            widget.iconData,
            color: Colors.white,
          ),
          backgroundColor: color,
        ),
      ),
      onTap: () {
        executeTutorial();
      },
    );
  }
}
